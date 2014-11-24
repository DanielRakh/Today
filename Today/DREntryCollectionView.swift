//
//  DREntryCollectionView.swift
//  Today
//
//  Created by Daniel on 11/18/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DREntryCollectionView: UICollectionView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clearColor()
        contentInset = UIEdgeInsetsMake(74, 0, 0, 0)
    }
}
