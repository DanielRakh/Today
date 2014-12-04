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
//    var navControllerDelegate:DRNavigationControllerDelegate?
    
    // This is the bottom bar view used to switch between the children. Similar to UITabBar.
    @IBOutlet private weak var navBar: DRNavBarView!
    
    // Read-only property of the current navigation controller
    private(set) var navController:UINavigationController!
    
    // Transition Animator
//    lazy private var transitionAnimator = TransitionAnimator()
    
    // Core Data MOC set in AppDelegate.
    var managedObjectContext:NSManagedObjectContext!
    
    
//MARK:
//MARK: Methods
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.todayDarkViewBackground()
//        navControllerDelegate = DRNavigationControllerDelegate()
        
        navBar.delegate = self
//        transitionAnimator.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        navController.delegate = self
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
    
    func animateNavBarAlongsideForMode(mode:Mode) {
        
        navController.transitionCoordinator()?.animateAlongsideTransitionInView(navBar, animation: { (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.navBar.performUnderlineAnimationForMode(mode, withDuration: context.transitionDuration())
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
    
    func addEntryButtonDidTouch(sender: AnyObject) {
        delegate?.addEntry()
    }
    
    func doButtonDidTouch(sender: AnyObject) {
        if navController.topViewController is DRDontViewController {
            navController.popToRootViewControllerAnimated(true)
//            animateNavBarAlongsideForMode(.Do)
        }
    }
    
    func dontButtonDidTouch(sender: AnyObject) {
        if navController.topViewController is DRDoViewController {
            navController.topViewController.performSegueWithIdentifier("pushToDontVC", sender:self.navController.topViewController)
//            animateNavBarAlongsideForMode(.Dont)
        }
    }
}



//extension DRMasterViewController: UINavigationControllerDelegate {
//    
//    
//    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        
//        transitionAnimator.operation = operation
//        transitionAnimator.transitionType = .Nervous
//        return transitionAnimator
//    }
//}
//
//
//extension DRMasterViewController: TranstionAnimatorDelegate {
//    
//    func visibleCells() -> [UICollectionViewCell] {
//
//        return [UICollectionViewCell]()
//    }
//}
