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
    }
    
    func setupTableView() {
        tableViewManager = DRTableViewManager(tableView: tableView, withCellIdentifier: cellIdentifier, mode:.Do)
    }
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




