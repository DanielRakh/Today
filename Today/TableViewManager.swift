//
//  TableViewManager.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit


class TableViewManager:NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var tableView:UITableView
    private var cellIdentifier:String
    
    init(tableView:UITableView, withCellIdentifier cellIdentifier:String) {
        self.tableView = tableView
        self.cellIdentifier = cellIdentifier
        super.init()
    }
   
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as UITableViewCell
        return cell
    }
    
}
