//
//  DoViewController.swift
//  Today
//
//  Created by Daniel on 10/29/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit


class DRDoViewController: UIViewController, DRMasterViewControllerDelegate {
    
    let cellIdentifier = "DoCell"

    @IBOutlet weak var collectionView: DREntryCollectionView!
    @IBOutlet weak var collectionViewLayout:UICollectionViewFlowLayout!
    
    var collectionViewManager:DRDoCollectionViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionViewManager = DRDoCollectionViewManager(collectionView: collectionView, items: [1,2], layout: collectionViewLayout, withCellIdentifier: cellIdentifier)
    }
}


extension DRDoViewController: DRMasterViewControllerDelegate {
    func addEntry() {
        collectionViewManager.insertRow()
    }
}
