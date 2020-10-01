//
//  Document+CoreDataClass.swift
//  Documents Core Data Relationships
//
//  Created by obbrbt on 10/1/20.
//
//

import UIKit
import CoreData

@objc(Document)
public class Document: NSManagedObject {

    convenience init?(name: String, content: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Document.entity(), insertInto: context)
        
        self.name = name
        self.content = content
        if let size = content?.count {
            self.size = Int64(size)
        } else {
            self.size = 0
        }
        
        self.rawModifiedDate = Date(timeIntervalSinceNow: 0)
    }
    
}
