//
//  CoreDataStack.swift
//  Today
//
//  Created by Daniel on 10/21/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import CoreData

class CoreDataStack {
    
    let managedObjectContext:NSManagedObjectContext!
   private let persistentStoreCoordinator: NSPersistentStoreCoordinator!
   private let model: NSManagedObjectModel!
   private let store: NSPersistentStore?
    
    init() {
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("Today", withExtension: "momd")
        
        model = NSManagedObjectModel(contentsOfURL: modelURL!)
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        let documentsURL = applicationDocumentsDirectory()
        let storeURL = documentsURL.URLByAppendingPathComponent("Today")
        let options = [NSMigratePersistentStoresAutomaticallyOption: true]
        var error:NSError? = nil
        store = persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType,
            configuration: nil,
            URL: storeURL,
            options: options,
            error: &error)
        
        if store == nil {
            println("Error adding persistent store: \(error)")
            abort()
        }
    }
    
    private func applicationDocumentsDirectory() -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        return urls.first!
    }
    
    func saveContext() {
        var error:NSError? = nil
        if managedObjectContext.hasChanges && !managedObjectContext.save(&error) {
            println("Could not save: \(error), \(error?.userInfo)")
        }
    }
    
    
}
