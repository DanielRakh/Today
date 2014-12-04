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
        items!.append(items!.count)
        tableView.insertRowsAtIndexPaths([nextAvailableIndexPath], withRowAnimation: .Left)
    }
    
}

//MARK: <UICollectionViewDataSource>

extension DRDoTableViewManager: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        return cell
    }
}


//MARK: <TableViewDelegate>
extension DRDoTableViewManager: UITableViewDelegate {
    
}







