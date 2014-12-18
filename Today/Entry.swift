//
//  Entry.swift
//  Today
//
//  Created by Daniel on 12/17/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

import Foundation
import CoreData

class Entry: NSManagedObject {

    @NSManaged var activity: String
    @NSManaged var alert: Bool
    @NSManaged var dateCreated: NSDate
    @NSManaged var done: Bool

}
