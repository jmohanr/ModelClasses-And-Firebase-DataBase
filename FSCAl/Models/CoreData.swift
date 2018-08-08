//
//  CoreData.swift
//  FSCAl
//
//  Created by Admin on 03/07/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class CoreData: NSObject {
  
    //MARK :- Saving Data Into CoreData
    
    static  func save(name: String,imageUrl:String,entityName:String,firstObject:String,secondObject:String) {
        let coreData = CoreDataStack.sharedInstance
        let managedObjectContext = coreData.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName:entityName, in: managedObjectContext)
        let contact = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        contact.setValue(name, forKey: firstObject)
        contact.setValue(imageUrl, forKey: secondObject)
        do {
            try managedObjectContext.save()
        
        } catch let error as NSError {
            print("Couldn't save. \(error)")
        }
    }
    //MARK :- Fetching Data From  CoreData
   static func fetchDetailsFormDb(entityName:String)->[NSManagedObject] {
     var  contacts = [NSManagedObject]()
        let coreData = CoreDataStack.sharedInstance
        let managedObjectContext = coreData.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:entityName)
        do {
          contacts = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        return contacts
    }
    
    static  func saveNonImageContacts(name: String,code:String,entityName:String,firstObject:String,secondObject:String) {
        let coreData = CoreDataStack.sharedInstance
        let managedObjectContext = coreData.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName:entityName, in: managedObjectContext)
        let contact = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        contact.setValue(name, forKey: firstObject)
        contact.setValue(code, forKey: secondObject)
        do {
            try managedObjectContext.save()
            
        } catch let error as NSError {
            print("Couldn't save. \(error)")
        }
    }
}
