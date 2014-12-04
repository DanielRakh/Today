//
//  DREntryCollectionView.swift
//  Today
//
//  Created by Daniel on 11/18/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DREntryTableView: UITableView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
   
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        
    }
    
    func setup() {
        backgroundColor = UIColor.clearColor()
        contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        separatorColor = UIColor.todayDarkNavBarUnselectedText()
    }
}
