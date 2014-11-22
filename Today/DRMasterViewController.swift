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
    @IBOutlet weak var innerContainerView: UIView!
    
    // The view controllers currently taking part in the transition
    var toViewController:UIViewController? {
        didSet {
            currentChildViewController = toViewController
        }
    }
    
    var fromViewController:UIViewController?
    
    lazy private var transitionAnimator = DRTransitionAnimator()
    
    
    // First child. Visible at first start-up.
    lazy var doVC:DRDoViewController = {
        let vc = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("DRDoViewController") as DRDoViewController
        vc.view.backgroundColor = UIColor.clearColor()
        return vc
    }()
    
    // Second Child.
    lazy var dontVC:DRDontViewController = {
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
    
    func cycleFromViewController(fromVC:UIViewController, toViewController toVC:UIViewController, forMode mode:Mode) {
        
        toViewController = toVC
        fromViewController = fromVC
        
        addChildViewController(toViewController!)
        
        fromViewController?.beginAppearanceTransition(false, animated: true)
        toViewController?.beginAppearanceTransition(true, animated: true)
        
        transitionAnimator.mode = mode
        transitionAnimator.transitionContext = self
        transitionAnimator.animateTransition(self)
        
    }

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
//MARK: Adopted Protocols:

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
