//
//  TableViewManager.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import UIKit
import CoreData


class DRTableViewManager:NSObject {
    
    private var tableView:UITableView!
    private var cellIdentifier:String!
    private var items:[Int]!
    private var entryService = DREntryService.sharedInstance
    private var mode:TodayMode!
    
    required init(tableView:UITableView, withCellIdentifier cellIdentifier:String, mode:TodayMode) {
        super.init()
        self.mode = mode
        self.items = Array(1...4)
        self.cellIdentifier = cellIdentifier
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
  
    }
    
    func configureCell(cell:DREntryTableViewCell, forIndexPath indexPath:NSIndexPath) {
        let entry = entryService.entryForIndexPath(indexPath, mode:mode)
        cell.textView.text = entry?.activity
        cell.setupForMode(mode)
        
    }
    
    func sectionsForMode(mode:TodayMode) -> [AnyObject]? {
        return mode == .Do ? entryService.sections.doSections : entryService.sections.dontSections
    }
    
}

//MARK: <UICollectionViewDataSource>

extension DRTableViewManager: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        //        if let sections = sectionsForMode(mode) {
        //            return sections.count
        //        } else {
        //            return 1
        //        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if let sectionInfo = sectionsForMode(mode)?[section] as? NSFetchedResultsSectionInfo {
        //            return sectionInfo.numberOfObjects
        //        } else {
        //            return 0
        //        }
        
        return items!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath) as DREntryTableViewCell
//                configureCell(cell, forIndexPath: indexPath)
        return cell
    }
}


///MARK: <TableViewDelegate>
extension DRTableViewManager: UITableViewDelegate {
    
}


///MARK: <DREntryServiceDelegate>
extension DRTableViewManager: DREntryServiceDelegate {
    
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






