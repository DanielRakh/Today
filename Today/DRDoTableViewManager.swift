//
//  TableViewManager.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit
import CoreData


class DRDoTableViewManager:NSObject {
    
    private var tableView:UITableView!
    private var cellIdentifier:String!
    private var items:[AnyObject]?
    private var entryService = DREntryService.sharedInstance
    
    required init(tableView:UITableView, withCellIdentifier cellIdentifier:String) {
        super.init()
        self.cellIdentifier = cellIdentifier
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func configureCell(cell:DREntryTableViewCell, forIndexPath indexPath:NSIndexPath) {
        let entry = entryService.entryForIndexPath(indexPath)
        cell.textView.text = entry?.activity
        
    }
    
}

//MARK: <UICollectionViewDataSource>

extension DRDoTableViewManager: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = entryService.sections {
            return sections.count
        } else {
            return 1
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionInfo = entryService.sections?[section] as? NSFetchedResultsSectionInfo {
            return sectionInfo.numberOfObjects
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath) as DREntryTableViewCell
        configureCell(cell, forIndexPath: indexPath)
        return cell
    }
}


///MARK: <TableViewDelegate>
extension DRDoTableViewManager: UITableViewDelegate {
    
}


///MARK: <DREntryServiceDelegate>
extension DRDoTableViewManager: DREntryServiceDelegate {
    
    func entryServiceWillChangeContent(entryService: DREntryService) {
        tableView.beginUpdates()
    }
    
    func entryServiceDidChangeContent(entryService: DREntryService) {
        tableView.endUpdates()
    }
    
    func insertRowsAtIndexPaths(indexPaths:[NSIndexPath]) {
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    func deleteRowsAtIndexPaths(indexPaths:[NSIndexPath]) {
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
    }
    
    func configureCellAtIndexPath(indexPath:NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as DREntryTableViewCell
        configureCell(cell, forIndexPath: indexPath)
    }
    
}






