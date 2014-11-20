//
//  MasterViewController.swift
//  Today
//
//  Created by Daniel on 10/21/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit
import CoreData


protocol DRMasterViewControllerDelegate {
    func addEntry()
}

class DRMasterViewController: UIViewController, DRTabBarViewDelegate  {
    
    @IBOutlet weak var tabBar: DRTabBarView!
    var delegate:DRMasterViewControllerDelegate?
    
    lazy var doVC:DRDoViewController = {
        let vc = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("DRDoViewController") as DRDoViewController
        vc.view.backgroundColor = UIColor.clearColor()
        return vc
    }()
    
    lazy var dontVC:DRDontViewController = {
        let vc = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("DRDontViewController") as DRDontViewController
        vc.view.backgroundColor = UIColor.clearColor()
        return vc
        }()
    
    //Set in AppDelegate
    var managedObjectContext:NSManagedObjectContext!
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.todayBackgroundBlack()
        tabBar.delegate = self
        self.delegate = doVC
        displayChildViewController(doVC)
        
    }
    
    //MARK: Container View Controller Helpers

    func displayChildViewController(viewController:UIViewController) {
        addChildViewController(viewController)
        viewController.view.frame = self.view.frame
        view.addSubview(viewController.view)
        viewController.didMoveToParentViewController(self)
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
    
    func cycleFromViewController(oldVC:UIViewController, toViewController newVC:UIViewController, forMode mode:Mode) {
        oldVC.willMoveToParentViewController(nil)
        addChildViewController(newVC)
        
        let oldEndFrame = oldVC.view.frame
        newVC.view.frame = newViewStartFrameForMode(mode)!
        
        transitionFromViewController(oldVC,
            toViewController: newVC,
            duration: 0.5,
            options: .CurveEaseInOut,
            animations: { () -> Void in
                newVC.view.frame = oldVC.view.frame
                if mode == .Do {
                    oldVC.view.frame = self.newViewStartFrameForMode(.Dont)
                } else if mode == .Dont {
                    oldVC.view.frame = self.newViewStartFrameForMode(.Do)
                }
                
            }) { (success:Bool) -> Void in
            oldVC.removeFromParentViewController()
                newVC.didMoveToParentViewController(self)
        }
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


//MARK:<DRTabBarViewDelegate>
extension DRMasterViewController:DRTabBarViewDelegate {
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




