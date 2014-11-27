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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("DoVC viewDidLoad")
        view.backgroundColor = UIColor.clearColor()
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
        collectionViewManager = DRDoCollectionViewManager(collectionView: collectionView, items: [1,2,3], layout: collectionViewLayout, withCellIdentifier: cellIdentifier)
    }
}


extension DRDoViewController: DRMasterViewControllerDelegate {
    func addEntry() {
        collectionViewManager.insertRow()
    }
}
