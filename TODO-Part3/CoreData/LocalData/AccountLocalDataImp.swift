//
//  AccountLocalData.swift
//  TODO-Part3
//
//  Created by Mac Pro on 10/30/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import CoreData

class AccountLocalData: BaseLocalData, AccountDataContract {
    
    func checkSignInAccount(username: String, password: String) -> Bool {
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(
                forEntityName: AccountContract.TableName.rawValue,
                in: managedObjet
            )
            fetchRequest.entity = entityDescription
            let predicate = "\(AccountContract.ColumnUsername.rawValue) == %@ AND \(AccountContract.ColumnPassword.rawValue) == %@"
            fetchRequest.predicate = NSPredicate(format: predicate, username, password)
        }
        do {
            let results = try AppDelegate.managedObjectContext?.fetch(fetchRequest) ?? nil
            if let results = results, results.count > 0 {
                return true
            }
        } catch {
            return false
        }
        return false
    }
    
    func getAllAccount() -> [Account]? {
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(
                forEntityName: AccountContract.TableName.rawValue,
                in: managedObjet
            )
            fetchRequest.entity = entityDescription
        }
        do {
            let results = try AppDelegate.managedObjectContext?.fetch(fetchRequest) ?? nil
            if let results = results, results.count > 0 {
                var accounts = [Account]()
                for result in results{
                    let account = result as? NSManagedObject
                    let username = account?.value(forKey: AccountContract.ColumnUsername.rawValue) as? String
                    let email = account?.value(forKey: AccountContract.ColumnEmail.rawValue) as? String
                    let password = account?.value(forKey: AccountContract.ColumnPassword.rawValue) as? String
                    let birthday = account?.value(forKey: AccountContract.ColumnBirthday.rawValue) as? String
                    if let username = username, let email = email, let password = password, let birthday = birthday {
                        accounts.append(Account(username: username, email: email, password: password, birthday: birthday))
                    }
                }
                return accounts
            }
        } catch {
            return nil
        }
        return nil
    }
    
    func checkAccountByName(username: String) -> Bool {
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(
                forEntityName: AccountContract.TableName.rawValue,
                in: managedObjet
            )
            fetchRequest.entity = entityDescription
            fetchRequest.predicate = NSPredicate(format: "\(AccountContract.ColumnUsername.rawValue)  == %@", username)
        }
        do {
            let results = try AppDelegate.managedObjectContext?.fetch(fetchRequest) ?? nil
            if let results = results, results.count > 0 {
                return true
            }
            
        } catch {
            return false
        }
        return false
    }
    
    func getAccountDetailByName(username: String) -> Account? {
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(
                forEntityName: AccountContract.TableName.rawValue,
                in: managedObjet
            )
            fetchRequest.entity = entityDescription
            fetchRequest.predicate = NSPredicate(format: "\(AccountContract.ColumnUsername.rawValue)  == %@", username)
        }
        do {
            let results = try AppDelegate.managedObjectContext?.fetch(fetchRequest) ?? nil
            if let results = results, results.count > 0 {
                let account = results.first as? NSManagedObject
                let username = account?.value(forKey: AccountContract.ColumnUsername.rawValue) as? String
                let email = account?.value(forKey: AccountContract.ColumnEmail.rawValue) as? String
                let password = account?.value(forKey: AccountContract.ColumnPassword.rawValue) as? String
                let birthday = account?.value(forKey: AccountContract.ColumnBirthday.rawValue) as? String
                if let username = username, let email = email, let password = password, let birthday = birthday {
                    let account = Account(username: username, email: email, password: password, birthday: birthday)
                    return account
                }
            }
        } catch {
            return nil
        }
        return nil
    }
    
    func checkAccountByEmail(email: String) -> Bool {
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(forEntityName: AccountContract.TableName.rawValue, in: managedObjet)
            fetchRequest.entity = entityDescription
            fetchRequest.predicate = NSPredicate(format: "\(AccountContract.ColumnEmail.rawValue) == %@", email)
        }
        do {
            let results = try AppDelegate.managedObjectContext?.fetch(fetchRequest) ?? nil
            if let results = results, results.count > 0 {
                return true
            }
        } catch {
            return false
        }
        return false
    }
    
    func insertAccount(account: Account) -> Bool {
        let context = AppDelegate.managedObjectContext
        if let context = context {
            let managedObject = NSEntityDescription.insertNewObject(
                forEntityName: AccountContract.TableName.rawValue,
                into: context
            )
            managedObject.setValue(account.username, forKey: AccountContract.ColumnUsername.rawValue)
            managedObject.setValue(account.email, forKey: AccountContract.ColumnEmail.rawValue)
            managedObject.setValue(account.password, forKey: AccountContract.ColumnPassword.rawValue)
            managedObject.setValue(account.birthday, forKey: AccountContract.ColumnBirthday.rawValue)
        }
        do {
            try context?.save()
            return true
        } catch  {
            return false
        }
    }
    
    func updateAccount(account: Account, currentUsername: String) -> Bool {
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(
                forEntityName: AccountContract.TableName.rawValue,
                in: managedObjet
            )
            fetchRequest.entity = entityDescription
            fetchRequest.predicate = NSPredicate(
                format: "\(AccountContract.ColumnUsername.rawValue)  == %@", currentUsername)
        }
        do {
            let results = try AppDelegate.managedObjectContext?.fetch(fetchRequest) ?? nil
            if let results = results, results.count > 0 {
                let accountUpdate = results[0] as! NSManagedObject
                accountUpdate.setValue(account.username, forKey: AccountContract.ColumnUsername.rawValue)
                accountUpdate.setValue(account.email, forKey: AccountContract.ColumnEmail.rawValue)
                accountUpdate.setValue(account.password, forKey: AccountContract.ColumnPassword.rawValue)
                accountUpdate.setValue(account.birthday, forKey: AccountContract.ColumnBirthday.rawValue)
                try accountUpdate.managedObjectContext?.save()
                return true
            }
        } catch {
            return false
        }
        return false
    }
    
    func deleteAccount(account: Account) -> Bool {
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(
                forEntityName: AccountContract.TableName.rawValue,
                in: managedObjet
            )
            fetchRequest.entity = entityDescription
            fetchRequest.predicate = NSPredicate(format: "\(AccountContract.ColumnUsername.rawValue)  == %@", account.username)
        }
        do {
            let results = try AppDelegate.managedObjectContext?.fetch(fetchRequest) ?? nil
            if let results = results, results.count > 0,
                let accountDel = results.first as? NSManagedObject {
                    AppDelegate.managedObjectContext?.delete(accountDel)
                    try AppDelegate.managedObjectContext?.save()
                    return true
            }
        } catch {
            return false
        }
        return false
    }
}
