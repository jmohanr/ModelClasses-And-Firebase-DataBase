//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by Admin on 29/06/18.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var image: String?
    @NSManaged public var title: String?

}
