//
//  Entries+CoreDataProperties.swift
//  SaveDateLocationPhoto
//
//  Created by Rimil Dey on 14/11/17.
//  Copyright © 2017 Rimil Dey. All rights reserved.
//

import Foundation
import CoreData


extension Entries {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entries> {
        return NSFetchRequest<Entries>(entityName: "Entries")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var entry: String?
    @NSManaged public var location: String?
    @NSManaged public var image: NSData?

}
