//
//  TransitionAnimator.swift
//  WaveTransition
//
//  Created by Daniel on 11/28/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

@objc protocol TranstionAnimatorDelegate {
    func visibleCells() -> [UICollectionViewCell]
}

enum TransitionType {
    case Subtle
    case Nervous
}

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration:CGFloat = 0.65
    let maxDelay:CGFloat = 0.15
    let screenWidth = UIScreen.mainScreen().bounds.width
    
    var transitionType:TransitionType?
    var operation:UINavigationControllerOperation?
    var delegate:TranstionAnimatorDelegate?
    
    convenience init(operation:UINavigationControllerOperation, transitionType:TransitionType) {
        self.init()
        self.operation! = operation
        self.transitionType! = transitionType
    }
    
    
    
    //MARK: UIViewControllerAnimatedTransitioningDelegate Methods
    
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
            delta = screenWidth
        } else {
            delta = -screenWidth
        }
        
        //Move the destination in place
        toView.frame = source
        //Kick it aside
        toView.transform = CGAffineTransformMakeTranslation(screenWidth, 0)
        
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
                            fromView.transform = CGAffineTransformMakeTranslation(self.screenWidth, 0)
                        }, completion: { (finished:Bool) -> Void in
                            transitionContext.completeTransition(true)
                            fromView.removeFromSuperview()
                    })
                }
                
                //Animates the cells of the starting view controller
                if fromVC is TranstionAnimatorDelegate {
                    if fromVC.respondsToSelector("visibleCells") {
                        let visibleCells = (fromVC as TranstionAnimatorDelegate).visibleCells() as NSArray
                        visibleCells.enumerateObjectsWithOptions(NSEnumerationOptions.Reverse, usingBlock: { (object:AnyObject!, idx:Int, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
                            let delay:NSTimeInterval = Double(idx)/Double(visibleCells.count) * Double(self.maxDelay)
                            
                            if self.transitionType == .Subtle {
                                UIView.animateWithDuration(Double(self.duration), delay: delay, options:.CurveEaseIn, animations: { () -> Void in
                                    (object as UICollectionViewCell).transform = CGAffineTransformMakeTranslation(-delta, 0)
                                    (object as UICollectionViewCell).alpha = 0
                                    }, completion: { (finished:Bool) -> Void in
                                        (object as UICollectionViewCell).transform = CGAffineTransformIdentity
                                })
                            } else {
                                UIView.animateWithDuration(Double(self.duration), delay: delay, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: { () -> Void in
                                    (object as UICollectionViewCell).transform = CGAffineTransformMakeTranslation(-delta, 0)
                                    (object as UICollectionViewCell).alpha = 0
                                    }, completion: { (finished:Bool) -> Void in
                                        (object as UICollectionViewCell).transform = CGAffineTransformIdentity
                                })
                            }
                        })
                    }
                }
                
                if toVC is TranstionAnimatorDelegate {
                    if toVC.respondsToSelector("visibleCells") {
                        let visibleCells = (toVC as TranstionAnimatorDelegate).visibleCells() as NSArray
                        visibleCells.enumerateObjectsWithOptions(NSEnumerationOptions.Reverse, usingBlock: { (object:AnyObject!, idx:Int, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
                            let delay:NSTimeInterval = Double(idx)/Double(visibleCells.count) * Double(self.maxDelay)
                            
                            (object as UICollectionViewCell).transform = CGAffineTransformMakeTranslation(delta, 0)
                            
                            if self.transitionType == .Subtle {
                                UIView.animateWithDuration(Double(self.duration), delay: delay, options:.CurveEaseIn, animations: { () -> Void in
                                    (object as UICollectionViewCell).transform = CGAffineTransformIdentity
                                    (object as UICollectionViewCell).alpha = 1
                                    }, completion: { (finished:Bool) -> Void in
                                })
                            } else {
                                UIView.animateWithDuration(Double(self.duration), delay: delay, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: { () -> Void in
                                    (object as UICollectionViewCell).transform = CGAffineTransformIdentity
                                    (object as UICollectionViewCell).alpha = 1
                                    }, completion: { (finished:Bool) -> Void in
                                })
                            }
                            
                        })
                }
            }
        }
    }
    
    
   /*
    func hideView(view:UIView, withDelay delay:NSTimeInterval, andDelta delta:CGFloat) {
    
        let animation = { () -> Void in
            view.transform = CGAffineTransformMakeTranslation(delta, 0)
            view.alpha = 0
        }
        
        let completion = { (finished:Bool) -> Void in
            view.transform = CGAffineTransformIdentity
        }
        
        if transitionType == .Subtle {
            UIView.animateWithDuration(Double(self.duration), delay: delay, options: .CurveEaseIn, animations: animation, completion: completion)
        } else {
            UIView.animateWithDuration(Double(self.duration), delay: delay, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .CurveEaseIn, animations: animation, completion: completion)
        }
    }
    
    func presentView(view:UIView, withDelay delay:NSTimeInterval, andDelta delta:CGFloat) {
        view.transform = CGAffineTransformMakeTranslation(delta, 0)
        let animation = { () -> Void in
            view.transform = CGAffineTransformIdentity
            view.alpha = 1
        }
        
        if transitionType == .Subtle {
            UIView.animateWithDuration(Double(self.duration), delay: delay, options: .CurveEaseIn, animations: animation, completion: nil)
        } else {
            UIView.animateWithDuration(Double(self.duration), delay: delay, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .CurveEaseIn, animations: animation, completion: nil)
        }
        
    }
    */
    
}
