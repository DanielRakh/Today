//
//  TableViewManager.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit


class TableViewManager:NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView:UITableView
    private var cellIdentifier:String
    private var entries:[AnyObject]?
    
    required init(tableView:UITableView, items:[AnyObject]?, withCellIdentifier cellIdentifier:String) {
        self.tableView = tableView
        self.cellIdentifier = cellIdentifier
        self.entries = items
        super.init()
    }
   
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let entries = self.entries {
            return entries.count
        } else {
            return 0
        }
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as UITableViewCell
        return cell
    }
    
}
