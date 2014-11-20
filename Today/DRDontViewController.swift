//
//  DontViewController.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRDontViewController: UIViewController, DRMasterViewControllerDelegate {
    
    let cellIdentifier = "DontCell"
    
    @IBOutlet weak var collectionView: DREntryCollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    var collectionViewManager:DRDoCollectionViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionViewManager = DRDoCollectionViewManager(collectionView: collectionView, items: [1,2,4,5], layout: collectionViewLayout, withCellIdentifier: cellIdentifier)
    }
    
}

extension DRDontViewController: DRMasterViewControllerDelegate {
    func addEntry() {
        collectionViewManager.insertRow()
    }
}
