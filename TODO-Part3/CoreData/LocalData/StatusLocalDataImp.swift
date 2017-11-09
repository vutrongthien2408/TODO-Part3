//
//  StatusLocalDataImp.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/10/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import CoreData

class StatusLocalDataImp: BaseLocalData, StatusDataContract {
    
    func getStatusByAccount(accountName: String) -> [Status]? {
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(
                forEntityName: Status.TableName,
                in: managedObjet
            )
            fetchRequest.entity = entityDescription
            fetchRequest.predicate = NSPredicate(format: "\(Status.ColumnAccountName)  == %@", accountName)
        }
        return loadStatus(fetchRequest: fetchRequest)
    }
    
    func getStatusByCategory(categoryName: String) -> [Status]? {
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(
                forEntityName: Status.TableName,
                in: managedObjet
            )
            fetchRequest.entity = entityDescription
            fetchRequest.predicate = NSPredicate(format: "\(Status.ColumnCategoryName)  == %@", categoryName)
        }
        return loadStatus(fetchRequest: fetchRequest)
    }
    
    func loadStatus(fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> [Status]? {
        do {
            let results = try AppDelegate.managedObjectContext?.fetch(fetchRequest) ?? nil
            if let results = results, results.count > 0 {
                var statuses = [Status]()
                for result in results{
                    let status = result as? NSManagedObject
                    let accountName = status?.value(forKey: Status.ColumnAccountName) as? String
                    let categoryName = status?.value(forKey: Status.ColumnCategoryName) as? String
                    let title = status?.value(forKey: Status.ColumnTitle) as? String
                    let description = status?.value(forKey: Status.ColumnDescriptions) as? String
                    let time = status?.value(forKey: Status.ColumnTime) as? String
                    if let accountName = accountName,
                        let categoryName = categoryName,
                        let description = description,
                        let title = title,
                        let time = time {
                        statuses.append(
                            Status(accountName: accountName,
                                   categoryName: categoryName,
                                   title: title,
                                   descriptions: description,
                                   time: time
                            )
                        )
                    }
                }
                return statuses
            }
        } catch {
            return nil
        }
        return nil
    }
    
    func insertStatus(status: Status) -> Bool {
        let context = AppDelegate.managedObjectContext
        if let context = context {
            let managedObject = NSEntityDescription.insertNewObject(
                forEntityName: Status.TableName,
                into: context
            )
            managedObject.setValue(status.accountName, forKey: Status.ColumnAccountName)
            managedObject.setValue(status.categoryName, forKey: Status.ColumnCategoryName)
            managedObject.setValue(status.title, forKey: Status.ColumnTitle)
            managedObject.setValue(status.descriptions, forKey: Status.ColumnDescriptions)
            managedObject.setValue(status.time, forKey: Status.ColumnTime)
        }
        do {
            try context?.save()
            return true
        } catch  {
            return false
        }
    }
    
    func updateStatus(status: Status) -> Bool {
        return false
    }
    
    func deleteStatus(status: Status) -> Bool {
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(
                forEntityName: Status.TableName,
                in: managedObjet
            )
            fetchRequest.entity = entityDescription
            fetchRequest.predicate = NSPredicate(
                format: "\(Status.ColumnAccountName) == %@ AND \(Status.ColumnTitle)  == %@",
                status.accountName,
                status.title
            )
        }
        do {
            let results = try AppDelegate.managedObjectContext?.fetch(fetchRequest) ?? nil
            if let results = results, results.count > 0,
                let statusDel = results.first as? NSManagedObject {
                AppDelegate.managedObjectContext?.delete(statusDel)
                try AppDelegate.managedObjectContext?.save()
                return true
            }
        } catch {
            return false
        }
        return false
    }
    
}
