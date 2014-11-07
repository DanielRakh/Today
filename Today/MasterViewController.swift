//
//  MasterViewController.swift
//  Today
//
//  Created by Daniel on 10/21/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit
import CoreData


protocol MasterViewControllerDelegate {
    func addEntryButtonDidTap()
}


class MasterViewController: UIViewController {
    
    @IBOutlet weak var doContainerView: UIView!
    @IBOutlet weak var addEntryButton: AddEntryButton!
    
    var delegate:MasterViewControllerDelegate?
    
    //Set in AppDelegate
    var managedObjectContext:NSManagedObjectContext!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: IBActions
    @IBAction func addEntry(sender: AnyObject) {
        delegate?.addEntryButtonDidTap()
    }
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedDoVC" {
            let doVc = segue.destinationViewController as DoViewController
            delegate = doVc
        }
    }

}
