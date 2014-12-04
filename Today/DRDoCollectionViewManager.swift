//
//  TableViewManager.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit


class DRDoCollectionViewManager:NSObject {
    
    private var collectionView:UICollectionView!
    private var cellIdentifier:String!
    private var items:[AnyObject]?
    private var collectionViewLayout:UICollectionViewFlowLayout!
    
    
    required init(collectionView:UICollectionView, items:[AnyObject]?, layout:UICollectionViewFlowLayout, withCellIdentifier cellIdentifier:String) {
        super.init()
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionViewLayout = layout
    }
    
    // Inserts row at next available index path
    func insertRow() {
        
        let nextAvailableIndexPath = NSIndexPath(forRow: self.items!.count, inSection: 0)
        items!.append(items!.count)
        collectionView.insertItemsAtIndexPaths([nextAvailableIndexPath])
    }
    
}

//MARK: <UICollectionViewDataSource>

extension DRDoCollectionViewManager: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items!.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        return cell
    }
}


//MARK: <TableViewDelegate>
extension DRDoCollectionViewManager: UICollectionViewDelegate {
    
}

extension DRDoCollectionViewManager: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            return CGSizeMake(collectionView.bounds.size.width - 30, 120)
    }
}







