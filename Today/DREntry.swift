//
//  Entry.swift
//  Today
//
//  Created by Daniel on 11/3/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import Foundation
import CoreData

class DREntry: NSManagedObject {

    @NSManaged var activity: String
    @NSManaged var type: NSNumber
    @NSManaged var date: NSDate

}
