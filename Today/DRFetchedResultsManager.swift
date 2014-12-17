//
//  FetchedResultsManager.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import Foundation
import CoreData

/// This is a protocol that mirrors the standard Fetched Results Controller

@objc protocol DRFetchedResultsManagerDelegate {
    
    optional func fetchedResultsManagerWillChangeContent(manager: DRFetchedResultsManager)
    
    optional func fetchedResultsManagerDidChangeContent(manager: DRFetchedResultsManager)
    
    optional func insertRowsAtIndexPaths(indexPaths:[NSIndexPath])
    
    optional func deleteRowsAtIndexPaths(indexPaths:[NSIndexPath])
    
    optional func configureCellAtIndexPath(indexPath:NSIndexPath)
}


class DRFetchedResultsManager:NSObject {
    
    ///MARK:
    ///MARK: Properties
    
    //MARK:Public
    weak var delegate:DRFetchedResultsManagerDelegate?
    
    var sections:[AnyObject]? {
       return fetchedResultsController.sections
    }
    
    ///MARK: Private
    private var fetchedResultsController:NSFetchedResultsController!
    
    ///Core Data Stack passed in App Delegate
    private var coreDataStack:DRCoreDataStack!
    
    ///MARK:
    ///MARK: Methods
    
    init(coreDataStack:DRCoreDataStack, entityName:String) {
        super.init()
        
        self.coreDataStack = coreDataStack
        
        ///Fetched Results Controller initalization.
        ///You can only set the fetch request ONCE, at initalization only.
        let fetchRequest = NSFetchRequest(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "activity", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        var error: NSError? =  nil
        if (!fetchedResultsController.performFetch(&error)) {
            println("Error: \(error?.localizedDescription)")
        }
        
    }
    
    func fetchedObjectAtIndexPath(indexPath:NSIndexPath) -> AnyObject {
        return fetchedResultsController.objectAtIndexPath(indexPath)
    }
    
}



//MARK:
//MARK: Fetched Results Controller Delegate
extension DRFetchedResultsManager: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        delegate?.fetchedResultsManagerWillChangeContent?(self)
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        delegate?.fetchedResultsManagerDidChangeContent?(self)
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            delegate?.insertRowsAtIndexPaths?([newIndexPath!])
        case .Delete:
            delegate?.deleteRowsAtIndexPaths?([indexPath!])
        case .Update:
            delegate?.configureCellAtIndexPath?(indexPath!)
        case .Move:
            delegate?.deleteRowsAtIndexPaths?([indexPath!])
            delegate?.insertRowsAtIndexPaths?([newIndexPath!])
        default:
            break
            
        }
    }
    
    
}