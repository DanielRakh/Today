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
    
    @IBOutlet weak var collectionView: DREntryCollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    lazy private var transitionAnimator = TransitionAnimator()
    
    var collectionViewManager:DRDoCollectionViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("DontVC viewDidLoad")
        view.backgroundColor = UIColor.clearColor()
        self.navigationController?.delegate = self
        transitionAnimator.delegate = self
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionViewManager = DRDoCollectionViewManager(collectionView: collectionView, items: Array(1...20), layout: collectionViewLayout, withCellIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("DontVC viewWillAppear")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("DontVC viewDidAppear")
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("DontVC View will dissappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("DontVC View did dissappear")
    }
    
}

extension DRDontViewController: DRMasterViewControllerDelegate {
    func addEntry() {
        collectionViewManager.insertRow()
    }
}


extension DRDontViewController: UINavigationControllerDelegate {
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transitionAnimator.operation = operation
        transitionAnimator.transitionType = .Nervous
        return transitionAnimator
    }
    
}


extension DRDontViewController: TranstionAnimatorDelegate {
    
    func visibleCells() -> [UICollectionViewCell] {
        
        return collectionView.visibleCells() as [UICollectionViewCell]
    }
}

