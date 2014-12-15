//
//  EntryService.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import Foundation

class DREntryService {
    
    let entityName = "Entry"
    
    //Singleton Instance
    class var sharedInstance: DREntryService {
        struct Static {
            static let instance = DREntryService()
        }
        return Static.instance
    }
    
    private var fetchedResultsManager:DRFetchedResultsManager!
    
    var coreDataStack:DRCoreDataStack! {
        didSet {
            fetchedResultsManager = DRFetchedResultsManager(coreDataStack: coreDataStack, entityName:entityName)
        }
    }

    /**
    

    
    */
    
}
