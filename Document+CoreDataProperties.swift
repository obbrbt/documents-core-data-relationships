//
//  Document+CoreDataProperties.swift
//  Documents Core Data Relationships
//
//  Created by obbrbt on 10/1/20.
//
//

import Foundation
import CoreData


extension Document {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }

    @NSManaged public var content: String?
    @NSManaged public var name: String?
    @NSManaged public var rawModifiedDate: Date?
    @NSManaged public var size: Int64
    @NSManaged public var category: Category?

}

extension Document : Identifiable {

}
