//
//  TableViewManager.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit


class DRDoTableViewManager:NSObject {
    
    private var tableView:UITableView!
    private var cellIdentifier:String!
    private var items:[AnyObject]?
    
    
    required init(tableView:UITableView, items:[AnyObject]?, withCellIdentifier cellIdentifier:String) {
        super.init()
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    // Inserts row at next available index path
    func insertRow() {
        
        let nextAvailableIndexPath = NSIndexPath(forRow: self.items!.count, inSection: 0)
        items! += [4]
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([nextAvailableIndexPath], withRowAnimation: .Left)
        tableView.endUpdates()
    }

}

//MARK: <TableViewDataSource>
extension DRDoTableViewManager: UITableViewDataSource {
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let entries = self.items {
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

//MARK: <TableViewDelegate>
extension DRDoTableViewManager: UITableViewDelegate {
    
    
}

