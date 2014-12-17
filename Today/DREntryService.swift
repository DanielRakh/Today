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
            fetchedResultsManager = DRFetchedResultsManager(coreDataStack: coreDataStack, entityName:entityName)
            fetchedResultsManager.delegate = self
        }
    }
    
    lazy var sections:[AnyObject]? = self.fetchedResultsManager.sections

    
    
    weak var delegate:DREntryServiceDelegate?
    
    ///MARK: Private
    private let entityName = "Entry"
    private var fetchedResultsManager:DRFetchedResultsManager!
    
    ///MARK:
    ///MARK: Methods    
    
    func saveEntry(activity:String, type:TodayMode) {
        
        let entity = NSEntityDescription.entityForName("Entry", inManagedObjectContext: coreDataStack.managedObjectContext)
        let entry = Entry(entity: entity!, insertIntoManagedObjectContext: coreDataStack.managedObjectContext)
        entry.activity = activity
        entry.type = type == .Do ? "Do" : "Dont"
        entry.alert = false
        entry.done = false
        entry.date = NSDate()
        coreDataStack.saveContext()
        
    }
    
    func deleteEntryAtIndexPath(indexPath:NSIndexPath) -> Entry {
        
        return Entry()
    }
    
    func entryForIndexPath(indexPath:NSIndexPath) -> Entry? {
        
        let object = fetchedResultsManager.fetchedObjectAtIndexPath(indexPath) as Entry
        if (object as Any) is Entry {
            return object
        } else {
            assert((object as Any) is Entry, "Object should be of type Entry")
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

