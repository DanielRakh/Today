//
//  DREntryCollectionView.swift
//  Today
//
//  Created by Daniel on 11/18/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit
import Swift

class DREntryTableView: UITableView {
    
    enum TableMode {
        case New
        case Normal
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.clearColor()
        contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        separatorColor = UIColor.todayOffGray()
        self.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func setupTableViewForMode(tableMode:TableMode) {
        
        let droppedFirstElementArray = dropFirst(self.visibleCells())
        droppedFirstElementArray.map({cell in
            (cell as UITableViewCell).pop_easeInEaseOut().alpha = tableMode == .New ? 0 : 1
        })
        
    }
}
