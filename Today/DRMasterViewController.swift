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
    var todayMode:TodayMode = .Do {
        didSet {
            addEntryButton.mode = todayMode
        }
    }
    
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
    
    //MARK:
    //MARK: Helpers
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

    //MARK:
    //MARK: IBActions
    
    @IBAction func addEntryButtonDidTouch(sender: AnyObject) {
        
        // Observers: DRNavBar, DREntryTableView, DREntryCell
        NSNotificationCenter.defaultCenter().postNotificationName("EntryButtonTapped", object: nil)
    }
}

//MARK:
//MARK: DRNavBarViewDelegate

extension DRMasterViewController: DRNavBarViewDelegate {
    
    func doButtonDidTouch(sender: AnyObject) {
        if navController.topViewController is DRDontViewController {
            self.todayMode = .Do
            navController.popToRootViewControllerAnimated(true)
        }
    }
    
    func dontButtonDidTouch(sender: AnyObject) {
        if navController.topViewController is DRDoViewController {
            self.todayMode = .Dont
            navController.topViewController.performSegueWithIdentifier("pushToDontVC", sender:self.navController.topViewController)
            }
    }
    
}






