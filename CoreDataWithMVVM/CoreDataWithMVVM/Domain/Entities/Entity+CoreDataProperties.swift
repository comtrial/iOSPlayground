//
//  Entity+CoreDataProperties.swift
//  CoreDataWithMVVM
//
//  Created by 최승원 on 2022/09/24.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?

}

extension Entity : Identifiable {

}
