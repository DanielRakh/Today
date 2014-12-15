//
//  FetchedResultsManager.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import Foundation
import CoreData


class DRFetchedResultsManager {
    
    ///MARK:
    ///MARK: Properties
    var fetchedResultsController:NSFetchedResultsController
    
    ///Core Data Stack passed in App Delegate
    private var coreDataStack:DRCoreDataStack

    var fetchedResults:[AnyObject]?
    
    
    ///MARK:
    ///MARK: Methods
    
    init(coreDataStack:DRCoreDataStack, entityName:String) {
        
        self.coreDataStack = coreDataStack
        
        ///Fetched Results Controller initalization.
        ///You can only set the fetch request ONCE, at initalization only.
        let fetchRequest = NSFetchRequest(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    
    func performFetch() {
        var error:NSError?
        if fetchedResultsController.performFetch(&error) == false {
            println("There was an error in the fetched results controller: \(error?.localizedDescription)")
        } else {
            fetchedResults = fetchedResultsController.fetchedObjects
            println("Fetched Results:\(fetchedResults)")
        }
    }
    
}



//MARK:
//MARK: Fetched Results Controller Delegate
extension DRFetchedResultsManager: NSFetchedResultsControllerDelegate {
    
    
}