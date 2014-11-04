//
//  EntryTableView.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class EntryTableView: UITableView {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.todayWhite
        tableFooterView = UIView(frame: CGRectZero)
        contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
    }
}
 