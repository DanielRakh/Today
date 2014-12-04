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

    @IBOutlet weak var collectionView: DREntryCollectionView!
    @IBOutlet weak var collectionViewLayout:UICollectionViewFlowLayout!
    
    var collectionViewManager:DRDoCollectionViewManager!
    lazy private var transitionAnimator = TransitionAnimator()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("DoVC viewDidLoad")
        view.backgroundColor = UIColor.clearColor()
        self.navigationController?.delegate = self
        transitionAnimator.delegate = self

        setupCollectionView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("DoVC viewWillAppear")

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
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
    
    
    
    func setupCollectionView() {
        collectionViewManager = DRDoCollectionViewManager(collectionView: collectionView, items: Array(1...20), layout: collectionViewLayout, withCellIdentifier: cellIdentifier)
    }
}


extension DRDoViewController: DRMasterViewControllerDelegate {
    func addEntry() {
        collectionViewManager.insertRow()
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
    
    func visibleCells() -> [UICollectionViewCell] {
        
        return collectionView.visibleCells() as [UICollectionViewCell]
    }
}




