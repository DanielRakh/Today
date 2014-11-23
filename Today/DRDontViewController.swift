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
    
    var collectionViewManager:DRDoCollectionViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("DontVC viewDidLoad")
        view.backgroundColor = UIColor.clearColor()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionViewManager = DRDoCollectionViewManager(collectionView: collectionView, items: [1,2,3], layout: collectionViewLayout, withCellIdentifier: cellIdentifier)
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
