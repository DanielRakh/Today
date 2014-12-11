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
    @IBOutlet private weak var navBar: DRNavBarView!
    
    // Read-only property of the current navigation controller
    private(set) var navController:UINavigationController!
    
    
    // Add Entry Button
    @IBOutlet weak var addEntryButton: DRAddEntryButton!
    
    
    // Core Data MOC set in AppDelegate.
    var managedObjectContext:NSManagedObjectContext!
    
    
//MARK:
//MARK: Methods
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.todayDarkGray()
        navBar.delegate = self
    }
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if navController.topViewController is DRDoViewController {
            self.delegate = navController.topViewController as DRDoViewController
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "navControllerEmbed" {
            navController = segue.destinationViewController as UINavigationController
        }
    }
    
//MARK:
//MARK: Helpers
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func animateNavBarAlongsideForMode(mode:TodayMode) {
        
        navController.transitionCoordinator()?.animateAlongsideTransitionInView(navBar, animation: { (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.navBar.performAnimationsForMode(mode, withDuration: context.transitionDuration())
            }, completion: { (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
                //
        })
    }
}

//MARK:
//MARK: Protocols

protocol DRMasterViewControllerDelegate {
    func addEntry()
}

//MARK: 
//MARK: Adopted Protocols:

//MARK: DRTabBarViewDelegate

extension DRMasterViewController: DRNavBarViewDelegate {
    
    @IBAction func addEntryButtonDidTouch(sender: AnyObject) {
        delegate?.addEntry()
    }
    
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
                    //
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
                //
            })
//            animateNavBarAlongsideForMode(.Dont)
        }
    }
}




