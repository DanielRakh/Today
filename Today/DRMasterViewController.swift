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
    func addEntryButtonDidTap()
}


class DRMasterViewController: UIViewController {
    
    @IBOutlet weak var doContainerView: UIView!
    @IBOutlet weak var addEntryButton: DRAddEntryButton!
    
    @IBOutlet weak var alignCenterYAddEntryButtonToTabBar: NSLayoutConstraint!
    var delegate:DRMasterViewControllerDelegate?
    
    //Set in AppDelegate
    var managedObjectContext:NSManagedObjectContext!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        doContainerView.backgroundColor = UIColor.clearColor()
        view.backgroundColor = UIColor.todayBackgroundBlack()
    }
    
    //MARK: IBActions
    @IBAction func addEntry(sender: AnyObject) {
        delegate?.addEntryButtonDidTap()
    }
    
    //Hide Status Bar
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedDoVC" {
            let doVc = segue.destinationViewController as DRDoViewController
            delegate = doVc
        }
    }

}
