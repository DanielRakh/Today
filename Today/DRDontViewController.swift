//
//  DontViewController.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRDontViewController: UIViewController {
    
    let cellIdentifier = "DontCell"
    
    @IBOutlet weak var tableView: DREntryTableView!
    lazy private var transitionAnimator = TransitionAnimator()
    var interactive = AMWaveTransition()

    
    //TODO: Change this to DRDontTableViewManager
    var tableViewManager:DRDoTableViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("DontVC viewDidLoad")
        view.backgroundColor = UIColor.clearColor()
        self.navigationController?.delegate = self
        transitionAnimator.delegate = self
        setupTableView()
    }
    
    
    func setupTableView() {
        //TODO: Change this to DRDontTableViewManager
        tableViewManager = DRDoTableViewManager(tableView: tableView, withCellIdentifier: cellIdentifier, mode:.Dont)
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("DontVC viewWillAppear")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        interactive.attachInteractiveGestureToNavigationController(self.navigationController)
        println("DontVC viewDidAppear")
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("DontVC View will dissappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.interactive.detachInteractiveGesture()
        println("DontVC View did dissappear")
    }
    
}


extension DRDontViewController: UINavigationControllerDelegate {
    
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


extension DRDontViewController: TranstionAnimatorDelegate {
    
    func visibleCells() -> [UITableViewCell] {
        
        return tableView.visibleCells() as [UITableViewCell]
    }
}

