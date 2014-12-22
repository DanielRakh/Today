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

class DRMasterViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    //MARK: Properties
    
    // This is the bottom bar view used to switch between the children. Similar to UITabBar.
    @IBOutlet private weak var navBar: DRNavBarView!
    
    // Read-only property of the current navigation controller
    private(set) var navController:UINavigationController!
    
    // Add Entry Button
    @IBOutlet weak var addEntryButton: DRAddEntryButton!
    
    // Today Mode
    var todayMode:TodayMode = .Do
    
    @IBOutlet weak var addEntryToolbar: DRAddEntryToolbar!
    
    
    //MARK:
    //MARK: Methods
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.todayOffWhite()
        navBar.delegate = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "navControllerEmbed" {
            navController = segue.destinationViewController as UINavigationController
        } else if segue.identifier == "presentAddEntryVC" {
            let addEntryVC = segue.destinationViewController as DRAddEntryViewController
            addEntryVC.transitioningDelegate = self
            addEntryVC.modalPresentationStyle = .FullScreen
            addEntryVC.todayMode = todayMode
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let presentationAnimator = DRTransitionSpringPopAnimator(transitionType: .Present)
        return presentationAnimator
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let dismissAnimator = DRTransitionSpringPopAnimator(transitionType: .Dismiss)
        return dismissAnimator
    }
    
    //    func animateAccessoryViewsAlongsideAddEntryPresentation() {
    //
    //        transitionCoordinator()?.animateAlongsideTransitionInView(view, animation: { (transitionContext:UIViewControllerTransitionCoordinatorContext!) -> Void in
    //            //
    //            }, completion: { (transitionContext:UIViewControllerTransitionCoordinatorContext!) -> Void in
    //            //
    //        })
    //    }
    
    
    
    //MARK:
    //MARK: Helpers
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    //    func animateNavBarAlongsideForMode(mode:TodayMode) {
    //
    //        navController.transitionCoordinator()?.animateAlongsideTransitionInView(navBar, animation: { (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
    //            self.navBar.performAnimationsForMode(mode, withDuration: context.transitionDuration())
    //            }, completion: { (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
    //                //
    //        })
    //    }
    
    //MARK:
    //MARK: IBActions
    
    @IBAction func addEntryButtonDidTouch(sender: AnyObject) {
        
        
        self.addEntryToolbar.hidden = false
        NSNotificationCenter.defaultCenter().postNotificationName("EntryButtonTapped", object: nil)

        NSObject.pop_animate({ () -> Void in
            self.navBar.pop_spring().alpha = 0
            }, completion: { (success:Bool) -> Void in
                self.addEntryToolbar.springPop(self.addEntryToolbar.closeIcon, reveal: true)
                self.addEntryToolbar.springPop(self.addEntryToolbar.checkmarkIcon, reveal: true)
        })
    }
}

//MARK:
//MARK: DRTabBarViewDelegate

extension DRMasterViewController: DRNavBarViewDelegate {
    
    func doButtonDidTouch(sender: AnyObject) {
        if navController.topViewController is DRDontViewController {
            navController.popToRootViewControllerAnimated(true)
            
            UIView.animateWithDuration(0.35,
                delay: 0,
                options: .CurveEaseInOut,
                animations: { () -> Void in
                    CATransaction.begin()
                    CATransaction.setAnimationDuration(0.35)
                    self.addEntryButton.applyGradientColorsForMode(.Do)
                    self.navBar.underlineView.applyGradientColorsForMode(.Do)
                    CATransaction.commit()
                }, completion: { (stop:Bool) -> Void in
                    self.todayMode = .Do
            })
        }
    }
    
    func dontButtonDidTouch(sender: AnyObject) {
        if navController.topViewController is DRDoViewController {
            navController.topViewController.performSegueWithIdentifier("pushToDontVC", sender:self.navController.topViewController)
            
            UIView.animateWithDuration(0.35,
                delay: 0,
                options: .CurveEaseInOut,
                animations: { () -> Void in
                    CATransaction.begin()
                    CATransaction.setAnimationDuration(0.35)
                    self.addEntryButton.applyGradientColorsForMode(.Dont)
                    self.navBar.underlineView.applyGradientColorsForMode(.Dont)
                    CATransaction.commit()
                }, completion: { (stop:Bool) -> Void in
                    self.todayMode = .Dont
            })
        }
    }
}






