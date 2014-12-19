//
//  DoViewController.swift
//  Today
//
//  Created by Daniel on 10/29/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit


class DRDoViewController: UIViewController {
    
    let cellIdentifier = "DoCell"

    @IBOutlet weak var tableView: DREntryTableView!
    
    var tableViewManager:DRTableViewManager!
    lazy private var transitionAnimator = TransitionAnimator()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("DoVC viewDidLoad")
        view.backgroundColor = UIColor.clearColor()
        self.navigationController?.delegate = self
        transitionAnimator.delegate = self

        setupTableView()
        
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "entryButtonTapped:", name: "EntryButtonTapped", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("DoVC viewWillAppear")

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("DoVC viewDidAppear")

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("DoVC View will dissappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("DoVC View did dissappear")
    }
    
    func setupTableView() {
        tableViewManager = DRTableViewManager(tableView: tableView, withCellIdentifier: cellIdentifier, mode:.Do)
    }
    
    func entryButtonTapped(sender:NSNotification) {
        
        /*
        
        User taps Button ->
        cells pop out in transition + Add Entry Button animates up and rotates 45 degrees to become close button ->
        Add Entry VC
        
        User taps close -> reverse transition -> Back to View Controller
        
        User taps done -> reverse transition where every cell pops back except the one on top.
        
        
        */
        
        
//        self.tableView.pop_spring().alpha = 0
        
        
        
        NSObject.pop_animate({ () -> Void in
            for (idx, cell) in enumerate(self.tableView.visibleCells()) {
                (cell as UITableViewCell).pop_duration = 0.25
                (cell as UITableViewCell).pop_easeInEaseOut().alpha = 0
                if idx % 2 == 0 {
                    (cell as UITableViewCell).pop_easeInEaseOut().frame = CGRectMake(-cell.bounds.size.width, cell.frame.origin.y, cell.bounds.size.width, cell.bounds.size.height)
                    //is Even
                } else {
                    (cell as UITableViewCell).pop_easeInEaseOut().frame = CGRectMake(cell.bounds.size.width, cell.frame.origin.y, cell.bounds.size.width, cell.bounds.size.height)
                }
            }
            }, completion: { (success:Bool) -> Void in
            //
        })
        
        
//        (self.tableView.visibleCells().reverse() as NSArray).pop_sequenceWithInterval(0.1, animations: { (object:AnyObject!, index:Int) -> Void in
//            if object is DREntryTableViewCell {
//                let icon = object as DREntryTableViewCell
//                icon.pop_springBounciness = 0
//                icon.pop_springSpeed = 18
//                icon.pop_spring().alpha = 1
//                icon.pop_spring().pop_scaleXY = CGPointMake(1.2, 1.2)
//            }
//            }) { (finished:Bool) -> Void in
//                //
//        }
    }
    
    
//    func tableViewSplitAnimation() {
//        NSObject.pop_animate({ () -> Void in
//            for (idx, cell) in enumerate(self.tableView.visibleCells()) {
//                (cell as UITableViewCell).pop_duration = 0.25
//                (cell as UITableViewCell).pop_easeInEaseOut().alpha = 0
//                if idx % 2 == 0 {
//                    (cell as UITableViewCell).pop_easeInEaseOut().frame = CGRectMake(-cell.bounds.size.width, cell.frame.origin.y, cell.bounds.size.width, cell.bounds.size.height)
//                    //is Even
//                } else {
//                    (cell as UITableViewCell).pop_easeInEaseOut().frame = CGRectMake(cell.bounds.size.width, cell.frame.origin.y, cell.bounds.size.width, cell.bounds.size.height)
//                }
//            }
//            }, completion: { (success:Bool) -> Void in
//                //
//        })
//    }
    
}


extension DRDoViewController: UINavigationControllerDelegate {
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
//        transitionAnimator.operation = operation
//        transitionAnimator.transitionType = .Nervous
//        return transitionAnimator
        
        if operation != .None {
            // Return your preferred transition operation
            return AMWaveTransition(operation: operation)
        }
        
        return nil;
    }
    
}


extension DRDoViewController: TranstionAnimatorDelegate {
    
    func visibleCells() -> [UITableViewCell] {
        
        return tableView.visibleCells() as [UITableViewCell]
    }
}




