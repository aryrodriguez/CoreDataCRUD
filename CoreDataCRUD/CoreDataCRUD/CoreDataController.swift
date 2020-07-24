//
//  CoreDataController.swift
//  CoreDataCRUD
//
//  Created by Ary on 22/07/2020.
//  Copyright © 2020 Ary. All rights reserved.
//

import UIKit
import CoreData

var appDelegate = UIApplication.shared.delegate as! AppDelegate
var context = appDelegate.persistentContainer.viewContext
class CoreDataController
{
    func create(contact:Contact)
    {
        let contactEntity = NSEntityDescription.entity(forEntityName:"CoreContact", in:context)!
        let contactObj = NSManagedObject(entity:contactEntity, insertInto:context)
        contactObj.setValue(contact.name, forKey:"name")
        contactObj.setValue(contact.phone, forKey:"phone")
       
        do {
            try context.save()
      
        } catch  {
            print("error creating contact.")
        }
    }
    
    func read()-> [Contact]
    {
        
        var contactList = Array<Contact>()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreContact")
        
        do{
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject]
            {
                let contact = Contact()
                contact.name = data.value(forKey:"name") as? String
                contact.phone = data.value(forKey:"phone") as? String
                contactList.append(contact)
            }
        }catch
        {
          print("fetch request error")
        }
        
        return contactList
    }
    
    func update(name:String, contact:Contact)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreContact")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let fetchObjects = try context.fetch(fetchRequest)
            let fetchContact = fetchObjects.first as! NSManagedObject
            fetchContact.setValue(contact.name, forKey: "name")
            fetchContact.setValue(contact.phone, forKey: "phone")
            
            do {
                try context.save()
                
            } catch  {
                print("error updating contact.")
            }
        } catch  {
            print("fetch request error")
        }
    }
    
    func delete(name:String)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreContact")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        do{
            let queryDelete = try context.fetch(fetchRequest)
            let contactTodelete = queryDelete[0] as! NSManagedObject
            context.delete(contactTodelete)
            do{
                try context.save()
            } catch
            {
                print("error deleting contact.")
            }
        }
        catch
        {
           print("fetch request error")
        }
    }
    
}
