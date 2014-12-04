//
//  TransitionAnimator.swift
//  WaveTransition
//
//  Created by Daniel on 11/28/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

//MARK:
//MARK: Protocol
@objc protocol TranstionAnimatorDelegate {
    func visibleCells() -> [UITableViewCell]
}


//MARK:
//MARK: Class
//*** This is the wave transition class used to between controllers ***//
class TransitionAnimator: NSObject {
    
    /** Transition Style
    
    - Subtle: Boring
    - Nervous: Default
    - Bounce: Exciting
    */
    enum TransitionType {
        case Subtle
        case Nervous
        case Bounce
    }
    
    /** Interactive transition Style
    
    - EdgePan: Standard UINavigationController edge gesture
    - FullScreenPan: The whole screen is game
    */
    enum InteractiveTransitionType {
        case EdgePan
        case FullScreenPan
    }
    
    
    //MARK: Properties
    
    /** Transition Type:
    - Subtle: Boring
    - Nervous: Default
    - Bounce: Exciting
    */
    var transitionType:TransitionType! = .Nervous
    
    /** Operation Type: Push or Pop */
    var operation:UINavigationControllerOperation!
    
    /** Transition Animator Delegate */
    var delegate:TranstionAnimatorDelegate?
    
    /** Animation Duration:
    The duration of the animation. The whole duration accounts for the maxDelay property.
    */
    let duration:CGFloat = 0.65
    
    /** Maximum Animation Delay:
    Max Delay that a call can wait before animating.
    */
    let maxDelay:CGFloat = 0.15
    

    /** Inset between view controllers:
    Sets the inset between view controllers. Defaults to 20 points.
    */
    var viewControllerInset:CGFloat = 20.0
    
    
    /** Alpha animation with interactive transition:
    Defualts to false
    */
    var animateAlphaWithInteractiveTransition = false
    
    
    /** Interactive Transition Type:
    Defaults to edge.
    */
    var interactiveTranstionType:InteractiveTransitionType! = .EdgePan
    
    
    //MARK: Private Properties
    private let screenWidth = UIScreen.mainScreen().bounds.width
    private let gesture:UIGestureRecognizer!
    
    
    
    
    
    //MARK:
    //MARK: Functions
    
    /**
    Attach the interactive gesture to the navigation controller. This will pop the current view controller when the user swipes from the left edge.
    Make sure to detach the gesture when done.
    
    :param: navigationController The UINavigationController that holds the current view controller
    */
    func attachInteractiveGestureToNavigationController(navigationController:UINavigationController) {
        
    }
    
    /** Detach the interactive gesture. */
    func detachInteractiveGesture() {
        
    }

}


//MARK: Non-Interactive
//MARK: UIViewControllerAnimatedTransitioningDelegate

extension TransitionAnimator:UIViewControllerAnimatedTransitioning {
    
    
    func visibleCellsForViewController(viewController:UIViewController) -> NSArray? {
        
        if viewController.respondsToSelector("visibleCells") {
            let visibleCells = (viewController as TranstionAnimatorDelegate).visibleCells()
            if visibleCells.count > 0 {
                return visibleCells
            }
        }
        return nil
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return Double(duration) + Double(maxDelay)
    }
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let containerView = transitionContext.containerView()
        
        let source = transitionContext.initialFrameForViewController(fromVC)
        
        containerView.addSubview(toView)
        
        var delta:CGFloat
        
        if operation == .Push {
            delta = screenWidth + viewControllerInset
            println("Push Delta: \(delta)")
        } else {
            delta = -screenWidth - viewControllerInset
            println("Pop Delta: \(delta)")
        }
        
        //Move the destination in place
        toView.frame = transitionContext.finalFrameForViewController(toVC)
        //Kick it aside
        toView.transform = CGAffineTransformMakeTranslation(delta, 0)
        
        containerView.backgroundColor = fromView.backgroundColor
        
        
        //First step is required to trigger the load of the visible cells.
        UIView.animateWithDuration(0,
            delay:0,
            options:.CurveEaseIn,
            animations: {
                //
            }) { (finished:Bool) -> Void in
                
                if self.operation == .Push {
                    toView.transform = CGAffineTransformMakeTranslation(1, 0)
                    
                    UIView.animateWithDuration(self.transitionDuration(transitionContext),
                        delay: 0,
                        options: .CurveEaseIn,
                        animations: { () -> Void in
                            toView.transform = CGAffineTransformIdentity
                        },
                        completion: { (finished:Bool) -> Void in
                            transitionContext.completeTransition(true)
                    })
                } else {
                    fromView.transform = CGAffineTransformMakeTranslation(1, 0)
                    toView.transform = CGAffineTransformIdentity
                    
                    UIView.animateWithDuration(self.transitionDuration(transitionContext),
                        delay: 0,
                        options: .CurveEaseIn,
                        animations: { () -> Void in
                            fromView.transform = CGAffineTransformMakeTranslation(0, 0)
                        }, completion: { (finished:Bool) -> Void in
                            transitionContext.completeTransition(true)
                            fromView.removeFromSuperview()

                    })
                }
                
                let fromViews = self.visibleCellsForViewController(fromVC)!
                let toViews = self.visibleCellsForViewController(toVC)!
                
                var currentViews:NSArray!
                var currentVisibleViewCount:Int!
                
                var cellAnimation = { (object:AnyObject!, idx:Int, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
                    let fromMode = currentViews == fromViews
                    let delay:NSTimeInterval = Double(idx) / Double(currentVisibleViewCount) * Double(self.maxDelay)
                    let view = object as UICollectionViewCell
                    
                    if fromMode == false {
                        view.transform = CGAffineTransformMakeTranslation(delta, 0)
                    }
                    
                    let animation = { () -> Void in
                        if fromMode == true {
//                            println("Delta:\(delta)")
                            view.transform = CGAffineTransformMakeTranslation(-delta, 0)
                            view.alpha = 0
                            println(view.transform.tx)
                        } else {
                            view.transform = CGAffineTransformIdentity;
                            view.alpha = 1;
                        }
                    }
                    
                    let completion = { (finished:Bool) -> Void in
                        if fromMode == true {
                            view.transform = CGAffineTransformIdentity
                        }
                    }
                    
                    if self.transitionType == .Subtle {
                        UIView.animateWithDuration(Double(self.duration), delay: delay, options: .CurveEaseIn, animations: animation, completion: completion)
                    } else if self.transitionType == .Nervous {
                        UIView.animateWithDuration(Double(self.duration), delay: delay, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .CurveEaseIn, animations: animation, completion: completion)
                    } else if self.transitionType == .Bounce {
                        UIView.animateWithDuration(Double(self.duration), delay: delay, options: .CurveEaseInOut, animations: animation, completion: completion)
                    }
                }
                
                
                currentViews = fromViews
                let viewsArrays = [fromViews, toViews]
                
                for array in viewsArrays {
                    if array.isEqualToArray(currentViews) {
                        currentVisibleViewCount = currentViews.count
                        currentViews.enumerateObjectsWithOptions(.Reverse, usingBlock: cellAnimation)
                    }
                }
        }
    }
}


                
                
//                //Animates the cells of the starting view controller
//                if fromVC is TranstionAnimatorDelegate {
//                    if fromVC.respondsToSelector("visibleCells") {
//                        let visibleCells = (fromVC as TranstionAnimatorDelegate).visibleCells() as NSArray
//                        visibleCells.enumerateObjectsWithOptions(NSEnumerationOptions.Reverse, usingBlock: { (object:AnyObject!, idx:Int, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
//                            let delay:NSTimeInterval = Double(idx)/Double(visibleCells.count) * Double(self.maxDelay)
//                            
//                            if self.transitionType == .Subtle {
//                                UIView.animateWithDuration(Double(self.duration), delay: delay, options:.CurveEaseIn, animations: { () -> Void in
//                                    (object as UICollectionViewCell).transform = CGAffineTransformMakeTranslation(-delta, 0)
//                                    (object as UICollectionViewCell).alpha = 0
//                                    }, completion: { (finished:Bool) -> Void in
//                                        (object as UICollectionViewCell).transform = CGAffineTransformIdentity
//                                })
//                            } else {
//                                UIView.animateWithDuration(Double(self.duration), delay: delay, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: { () -> Void in
//                                    (object as UICollectionViewCell).transform = CGAffineTransformMakeTranslation(-delta, 0)
//                                    (object as UICollectionViewCell).alpha = 0
//                                    }, completion: { (finished:Bool) -> Void in
//                                        (object as UICollectionViewCell).transform = CGAffineTransformIdentity
//                                })
//                            }
//                        })
//                    }
//                }
//                
//                if toVC is TranstionAnimatorDelegate {
//                    if toVC.respondsToSelector("visibleCells") {
//                        let visibleCells = (toVC as TranstionAnimatorDelegate).visibleCells() as NSArray
//                        visibleCells.enumerateObjectsWithOptions(NSEnumerationOptions.Reverse, usingBlock: { (object:AnyObject!, idx:Int, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
//                            let delay:NSTimeInterval = Double(idx)/Double(visibleCells.count) * Double(self.maxDelay)
//                            
//                            (object as UICollectionViewCell).transform = CGAffineTransformMakeTranslation(delta, 0)
//                            
//                            if self.transitionType == .Subtle {
//                                UIView.animateWithDuration(Double(self.duration), delay: delay, options:.CurveEaseIn, animations: { () -> Void in
//                                    (object as UICollectionViewCell).transform = CGAffineTransformIdentity
//                                    (object as UICollectionViewCell).alpha = 1
//                                    }, completion: { (finished:Bool) -> Void in
//                                })
//                            } else {
//                                UIView.animateWithDuration(Double(self.duration), delay: delay, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: { () -> Void in
//                                    (object as UICollectionViewCell).transform = CGAffineTransformIdentity
//                                    (object as UICollectionViewCell).alpha = 1
//                                    }, completion: { (finished:Bool) -> Void in
//                                })
//                            }
//                        })
//                    }
//                }
//        }
//    }
//}
