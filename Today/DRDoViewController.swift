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
    
    var tableViewManager:DRDoTableViewManager!
    lazy private var transitionAnimator = TransitionAnimator()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("DoVC viewDidLoad")
        view.backgroundColor = UIColor.clearColor()
        self.navigationController?.delegate = self
        transitionAnimator.delegate = self

        setupTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("DoVC viewWillAppear")

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
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
        tableViewManager = DRDoTableViewManager(tableView: tableView, items: Array(1...20), withCellIdentifier: cellIdentifier)
    }
}


extension DRDoViewController: DRMasterViewControllerDelegate {
    func addEntry() {
        tableViewManager.insertRow()
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




