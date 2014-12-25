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
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setupTableViewForNewMode:", name: "EntryButtonTapped", object: nil)
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
    
    
    func setupTableViewForNewMode(notification:NSNotification) {
        
        setupTableViewForMode(.New)
    }
    
    func setupTableViewForMode(entryMode:EntryMode) {
        
        let droppedFirstElementArray = dropFirst(self.visibleCells())
        droppedFirstElementArray.map({cell in
            (cell as UITableViewCell).pop_easeInEaseOut().alpha = entryMode == .New ? 0.20 : 1
        })
    }
}
