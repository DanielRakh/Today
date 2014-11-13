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
        backgroundColor = UIColor.todayBackgroundBlack()
        tableFooterView = UIView(frame: CGRectZero)
        contentInset = UIEdgeInsetsMake(22, 0, 0, 0)
    }
}
 