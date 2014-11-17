//
//  EntryTableView.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DREntryTableView: UITableView {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
        backgroundColor = UIColor.clearColor()
        tableFooterView = UIView(frame: CGRectZero)
        separatorStyle = .None
        
    }
}
 