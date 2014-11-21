//
//  MasterViewController.swift
//  Today
//
//  Created by Daniel on 10/21/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit
import CoreData

/*
    DRMasterViewController is a custom container controller that serves as the root controller of the app.
*/

class DRMasterViewController: UIViewController {
    
//MARK: Properties
    
    var delegate:DRMasterViewControllerDelegate?
    
    // This is the bottom bar view used to switch between the children. Similar to UITabBar.
    @IBOutlet private weak var tabBar: DRTabBarView!
    
    // Read-only property of the current child
    private(set) var currentChildViewController:UIViewController!
    
    /* We add the children to this view instead of self.view because when you add a new child view controller,
     we don't want to obstruct that supplementary views on self.view (in this case DRTabBar). */
    @IBOutlet private weak var innerContainerView: UIView!
    
    // The view controllers currently taking part in the transition
    private var toViewController:UIViewController?
    private var fromViewController:UIViewController?
    
    lazy private var transitionAnimator = DRTransitionAnimator()
    
    
    // First child. Visible at first start-up.
    lazy private var doVC:DRDoViewController = {
        let vc = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("DRDoViewController") as DRDoViewController
        vc.view.backgroundColor = UIColor.clearColor()
        return vc
    }()
    
    // Second Child.
    lazy private var dontVC:DRDontViewController = {
        let vc = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("DRDontViewController") as DRDontViewController
        vc.view.backgroundColor = UIColor.clearColor()
        return vc
        }()
    
    
    // Core Data MOC set in AppDelegate.
    var managedObjectContext:NSManagedObjectContext!
    
    
//MARK:
//MARK: Methods
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.todayBackgroundBlack()
        
        tabBar.delegate = self
        
        self.delegate = doVC
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Apple adds children in viewWillAppear as well with UINavigationController and UITabBarController.
        // Our custom container should follow suite. 
        
        displayChildViewController(doVC)
        
    }
    
    //MARK: Container View Controller Helpers
    
    override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
        /*
        *  This is important.
        *  If you return YES here, the containment-methods (addChildViewController:, etc.) will call appearance methods (viewWillAppear:, etc.)
        *  on the childViewControllers. Problem: They are not really reliable in that case ;). E.g. viewWillAppear:, etc. will not get called properly.
        *  You would most likely get a warning: "Unbalanced calls to appearance methods", when adding / removing childVCs.
        *  Doing it on your own is much more accurate / reliable.
        */
        return false
    }

    func displayChildViewController(viewController:UIViewController) {
        addChildViewController(viewController)
        viewController.view.frame = innerContainerView.frame
        viewController.beginAppearanceTransition(true, animated: false)
        innerContainerView.addSubview(viewController.view)
        viewController.endAppearanceTransition()
        viewController.didMoveToParentViewController(self)
        currentChildViewController = viewController
    }
    
    func newViewStartFrameForMode(mode:Mode) -> CGRect! {
        switch mode {
        
        case .Do:
            return CGRectMake(-doVC.view.bounds.size.width, view.frame.origin.y, doVC.view.bounds.size.width, doVC.view.bounds.size.height)
            
        case .Dont:
             return CGRectMake(dontVC.view.bounds.size.width, view.frame.origin.y, dontVC.view.bounds.size.width, dontVC.view.bounds.size.height)
        default:
            println("There was an error geting the new view start frame")
        
        }
        
        return nil
    }
    
    func cycleFromViewController(fromVC:UIViewController, toViewController toVC:UIViewController, forMode mode:Mode) {
        
        toViewController = toVC
        fromViewController = fromVC
        
        addChildViewController(toViewController!)
        fromViewController?.beginAppearanceTransition(false, animated: true)
        toViewController?.beginAppearanceTransition(true, animated: true)
        transitionAnimator.mode = mode
        transitionAnimator.animateTransition(self)
        
    }
    
    
    
    
//    func cycleFromViewController(oldVC:UIViewController, toViewController newVC:UIViewController, forMode mode:Mode) {
//        oldVC.willMoveToParentViewController(nil)
//        addChildViewController(newVC)
//        let oldEndFrame = oldVC.view.frame
//        newVC.view.frame = newViewStartFrameForMode(mode)!
//        
//        transitionFromViewController(oldVC,
//            toViewController: newVC,
//            duration: 0.5,
//            options: .CurveEaseInOut,
//            animations: { () -> Void in
//                UIView.performWithoutAnimation({ () -> Void in
//                    UIApplication.sharedApplication().beginIgnoringInteractionEvents()
//                    self.view.insertSubview(self.tabBar, aboveSubview: newVC.view)
//                })
//                newVC.view.frame = oldVC.view.frame
//                if mode == .Do {
//                    oldVC.view.frame = self.newViewStartFrameForMode(.Dont)
//                } else if mode == .Dont {
//                    oldVC.view.frame = self.newViewStartFrameForMode(.Do)
//                }
//                
//                
//            }) { (success:Bool) -> Void in
//            oldVC.removeFromParentViewController()
//                newVC.didMoveToParentViewController(self)
//                self.currentChildViewController = newVC
//                UIApplication.sharedApplication().endIgnoringInteractionEvents()
//        }
//        
//
//    }
    
    
    func transitionControllersForMode(mode:Mode) {
        let oldVc = mode == .Do ? dontVC : doVC
        let newVC = mode == .Do ? doVC : dontVC
        cycleFromViewController(oldVc, toViewController: newVC, forMode: mode)
    }
    
    //MARK: General Helpers
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}


//MARK:
//MARK: Protocols

protocol DRMasterViewControllerDelegate {
    func addEntry()
}




//MARK: 
//MARK: Conformed Delegates:

//MARK: DRTabBarViewDelegate

extension DRMasterViewController: DRTabBarViewDelegate {
    func addEntryButtonDidTouch(sender: AnyObject) {
        delegate?.addEntry()
    }
    
    func doButtonDidTouch(sender: AnyObject) {
        transitionControllersForMode(.Do)
    }
    
    func dontButtonDidTouch(sender: AnyObject) {
        transitionControllersForMode(.Dont)
    }
}

//MARK: UIViewControllerContextTransitioning

extension DRMasterViewController: UIViewControllerContextTransitioning {
    
    func containerView() -> UIView {
        return innerContainerView
    }
    
    // Most of the time this is YES. For custom transitions that use the new UIModalPresentationCustom
    // presentation type we will invoke the animateTransition: even though the transition should not be
    // animated. This allows the custom transition to add or remove subviews to the container view.
    func isAnimated() -> Bool {
        return false
    }
    
    func isInteractive() -> Bool  {
        return false
    }
    
    func transitionWasCancelled() -> Bool {
        return false
    }
    
    func presentationStyle() -> UIModalPresentationStyle {
        return .Custom
    }
    
    // It only makes sense to call these from an interaction controller that
    // conforms to the UIViewControllerInteractiveTransitioning protocol and was
    // vended to the system by a container view controller's delegate or, in the case
    // of a present or dismiss, the transitioningDelegate.
    func updateInteractiveTransition(percentComplete: CGFloat) {
        
    }
    func finishInteractiveTransition() {
        
    }
    func cancelInteractiveTransition() {
        
    }
    
    // This must be called whenever a transition completes (or is cancelled.)
    // Typically this is called by the object conforming to the
    // UIViewControllerAnimatedTransitioning protocol that was vended by the transitioning
    // delegate.  For purely interactive transitions it should be called by the
    // interaction controller. This method effectively updates internal view
    // controller state at the end of the transition.
    func completeTransition(didComplete: Bool) {
        if didComplete == true {
            fromViewController?.view.removeFromSuperview()
            fromViewController?.endAppearanceTransition()
            toViewController?.endAppearanceTransition()
        } else {
            fromViewController?.endAppearanceTransition()
            toViewController?.endAppearanceTransition()
        }
        
        fromViewController = nil
        toViewController = nil

        
    }
    
    // Currently only two keys are defined by the
    // system - UITransitionContextToViewControllerKey, and
    // UITransitionContextFromViewControllerKey.
    // Animators should not directly manipulate a view controller's views and should
    // use viewForKey: to get views instead.
    func viewControllerForKey(key: String) -> UIViewController? {
        if key == UITransitionContextFromViewControllerKey {
            return fromViewController
        } else {
            return toViewController
        }
    }
    
    // Currently only two keys are defined by the system -
    // UITransitionContextFromViewKey, and UITransitionContextToViewKey
    // viewForKey: may return nil which would indicate that the animator should not
    // manipulate the associated view controller's view.
    @availability(iOS, introduced=8.0)
    func viewForKey(key: String) -> UIView? {
        if key == UITransitionContextFromViewKey {
            return fromViewController?.view
        } else {
            return toViewController?.view
        }
    }
    
    @availability(iOS, introduced=8.0)
    func targetTransform() -> CGAffineTransform {
        return CGAffineTransformIdentity
    }
    
    // The frame's are set to CGRectZero when they are not known or
    // otherwise undefined.  For example the finalFrame of the
    // fromViewController will be CGRectZero if and only if the fromView will be
    // removed from the window at the end of the transition. On the other
    // hand, if the finalFrame is not CGRectZero then it must be respected
    // at the end of the transition.
    func initialFrameForViewController(vc: UIViewController) -> CGRect {
        return CGRectZero
    }
    func finalFrameForViewController(vc: UIViewController) -> CGRect {
        return CGRectZero
    }
    
}




