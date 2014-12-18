//
//  EntryService.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import Foundation
import CoreData


/// This is a protocol that mirrors the Fetched Results Manager Delegate
@objc protocol DREntryServiceDelegate {
    
    optional func entryServiceWillChangeContent(entryService:DREntryService)
    
    optional func entryServiceDidChangeContent(entryService: DREntryService)
    
    optional func insertRowsAtIndexPaths(indexPaths:[NSIndexPath])
    
    optional func deleteRowsAtIndexPaths(indexPaths:[NSIndexPath])
    
    optional func configureCellAtIndexPath(indexPath:NSIndexPath)
    
}

class DREntryService: NSObject {
    
    ///MARK:
    ///MARK:Properties
    
    //MARK:Public
    
    //Singleton Instance
    class var sharedInstance: DREntryService {
        struct Static {
            static let instance = DREntryService()
        }
        return Static.instance
    }
    
    var coreDataStack:DRCoreDataStack!
        {
        didSet {
            fetchedResultsManager = DRFetchedResultsManager(coreDataStack: coreDataStack, entities:(doEntityName, dontEntityName))
            fetchedResultsManager.delegate = self
        }
    }
    
    lazy var sections:(doSections:[AnyObject]?, dontSections:[AnyObject]?) = self.fetchedResultsManager.sections
    
    
    
    weak var delegate:DREntryServiceDelegate?
    
    ///MARK: Private
    private let doEntityName = "DoEntry"
    private let dontEntityName = "DontEntry"
    private var fetchedResultsManager:DRFetchedResultsManager!
    
    ///MARK:
    ///MARK: Methods
    
    
    private func prepareEntryEntityForMode(todayMode:TodayMode, inManagedObjectContext context:NSManagedObjectContext) -> Entry {
        let entity = NSEntityDescription.entityForName(todayMode == .Do ? doEntityName : dontEntityName, inManagedObjectContext: context)
        
        var entry:Entry!
        
        if todayMode == .Do {
            entry = DoEntry(entity: entity!, insertIntoManagedObjectContext: coreDataStack.managedObjectContext) as DoEntry
        } else if todayMode == .Dont {
            entry = DontEntry(entity: entity!, insertIntoManagedObjectContext: coreDataStack.managedObjectContext) as DontEntry
        }
        
        assert(entry != nil, "Entry cannot be nil")
        
        return entry
    }
    
    
    func saveEntry(activity:String, type:TodayMode) {
        
        let entry = prepareEntryEntityForMode(type, inManagedObjectContext: coreDataStack.managedObjectContext)
        entry.activity = activity
        entry.alert = false
        entry.done = false
        entry.dateCreated = NSDate()
        
        coreDataStack.saveContext()
        
    }
    
    
    func deleteEntryAtIndexPath(indexPath:NSIndexPath) -> Entry {
        
        return Entry()
    }
    
    func entryForIndexPath(indexPath:NSIndexPath, mode:TodayMode) -> Entry? {
        
        let object:AnyObject = fetchedResultsManager.fetchedObjectAtIndexPath(indexPath, mode: mode)
        
        if object is Entry {
            return (object as Entry)
        } else {
            assert(object is Entry, "Object should be of type Entry")
            return nil
        }
    }
    
}


//MARK:
//MARK: Fetched Results Manager Delegate
extension DREntryService: DRFetchedResultsManagerDelegate {
    
    func fetchedResultsManagerWillChangeContent(manager: DRFetchedResultsManager) {
        delegate?.entryServiceWillChangeContent?(self)
    }
    
    func fetchedResultsManagerDidChangeContent(manager: DRFetchedResultsManager) {
        delegate?.entryServiceDidChangeContent?(self)
    }
    
    func insertRowsAtIndexPaths(indexPaths:[NSIndexPath]) {
        delegate?.insertRowsAtIndexPaths?(indexPaths)
    }
    
    func deleteRowsAtIndexPaths(indexPaths:[NSIndexPath]) {
        delegate?.deleteRowsAtIndexPaths?(indexPaths)
    }
    
    func configureCellAtIndexPath(indexPath:NSIndexPath) {
        delegate?.configureCellAtIndexPath?(indexPath)
    }
    
}

