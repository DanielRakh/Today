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
    
    ///Test Array. Comment out when not testing
    private var items:[Int]!

    private var tableView:DREntryTableView!
    private var cellIdentifier:String!
    private var entryService = DREntryService.sharedInstance
    private var todayMode:TodayMode!
    
    required init(tableView:DREntryTableView, withCellIdentifier cellIdentifier:String, mode:TodayMode) {
        super.init()
        self.todayMode = mode
        self.items = Array(1...4)
        self.cellIdentifier = cellIdentifier
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "entryButtonTapped:", name: "EntryButtonTapped", object: nil)
  
    }
    
    func configureCell(cell:DREntryTableViewCell, forIndexPath indexPath:NSIndexPath) {
        let entry = entryService.entryForIndexPath(indexPath, mode:todayMode)
        cell.textView.text = entry?.activity
        cell.setupForMode(.Normal, todayMode:.Do)
        
    }
    
    func sectionsForMode(mode:TodayMode) -> [AnyObject]? {
        return mode == .Do ? entryService.sections.doSections : entryService.sections.dontSections
    }
    
    func entryButtonTapped(sender:NSNotification) {
        items.append(1)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as DREntryTableViewCell
        cell.textView.text = ""
        cell.textView.becomeFirstResponder()
        tableView.setupTableViewForMode(.New)
        
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






