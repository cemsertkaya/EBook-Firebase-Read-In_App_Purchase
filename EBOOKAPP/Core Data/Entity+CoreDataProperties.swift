//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Cem Sertkaya on 1.02.2021.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var isActive: bool?

}
