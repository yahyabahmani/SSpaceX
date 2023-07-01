//
//  Bookmark+CoreDataProperties.swift
//  SSpaceX
//
//  Created by Jabama on 7/1/23.
//
//

import Foundation
import CoreData


extension Bookmark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmark> {
        return NSFetchRequest<Bookmark>(entityName: "Bookmark")
    }

    @NSManaged public var id: String

}

extension Bookmark : Identifiable {

}
