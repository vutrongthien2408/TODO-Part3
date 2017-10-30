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
    
    func getAllAccount() -> [Account] {
        var accounts = [Account]()
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(forEntityName: AccountContract.TableName.rawValue, in: managedObjet)
            fetchRequest.entity = entityDescription
        }
        
        do {
            let result = try AppDelegate.managedObjectContext?.fetch(fetchRequest) ?? nil
            let n = result?.count ?? 0
            if (n > 0) {
                for i in 0...n-1 {
                    let account = result?[i] as? NSManagedObject
                    let username = account?.value(forKey: AccountContract.ColumnUsername.rawValue) as? String
                    let email = account?.value(forKey: AccountContract.ColumnEmail.rawValue) as? String
                    let password = account?.value(forKey: AccountContract.ColumnPassword.rawValue) as? String
                    let birthday = account?.value(forKey: AccountContract.ColumnBirthday.rawValue) as? String
                    if let username = username, let email = email, let password = password, let birthday = birthday {
                        accounts.append(Account(username: username, email: email, password: password, birthday: birthday))
                    }
                }
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return accounts
    }
    
    func checkAccountByName(username: String) -> Bool {
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(forEntityName: AccountContract.TableName.rawValue, in: managedObjet)
            fetchRequest.entity = entityDescription
        }
        do {
            let result = try AppDelegate.managedObjectContext?.fetch(fetchRequest) ?? nil
            let n = result?.count ?? 0
            if (n > 0) {
                for i in 0...n-1 {
                    let account = result?[i] as? NSManagedObject
                    let name = account?.value(forKey: AccountContract.ColumnUsername.rawValue) as? String
                    if name == username {
                        return true
                    }
                }
            }
        } catch {
            return false
        }
        return false
    }
    
    func checkAccountByEmail(email: String) -> Bool {
        
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(forEntityName: AccountContract.TableName.rawValue, in: managedObjet)
            fetchRequest.entity = entityDescription
        }
        do {
            let result = try AppDelegate.managedObjectContext?.fetch(fetchRequest) ?? nil
            let n = result?.count ?? 0
            if (n > 0) {
                for i in 0...n-1 {
                    let account = result?[i] as? NSManagedObject
                    let emailChecked =  account?.value(forKey: AccountContract.ColumnUsername.rawValue) as? String
                    if emailChecked == email {
                        return true
                    }
                }
            }
        } catch {
            return false
        }
        return false
    }
    
    func insertAccount(account: Account) -> Bool {
        let context = AppDelegate.managedObjectContext
        if let context = context {
            let managedObject = NSEntityDescription.insertNewObject(forEntityName: AccountContract.TableName.rawValue, into: context)
            managedObject.setValue(account.getUsername(), forKey: AccountContract.ColumnUsername.rawValue)
            managedObject.setValue(account.getEmail(), forKey: AccountContract.ColumnEmail.rawValue)
            managedObject.setValue(account.getPassword(), forKey: AccountContract.ColumnPassword.rawValue)
            managedObject.setValue(account.getBirthday(), forKey: AccountContract.ColumnBirthday.rawValue)
        }
       
        do {
            try context?.save()
            return true
        } catch  {
            return false
        }
    }
    
    func updateAccount(account: Account) -> Bool {
        return false
    }
    
    func deleteAccount(account: Account) -> Bool {
        
        if let managedObjet = managedObjet {
            let entityDescription = NSEntityDescription.entity(forEntityName: AccountContract.TableName.rawValue, in: managedObjet)
            fetchRequest.entity = entityDescription
        }
        do {
            let result = try AppDelegate.managedObjectContext?.fetch(fetchRequest) ?? nil
            let n = result?.count ?? 0
            if (n > 0) {
                for i in 0...n-1 {
                    let accountDel = result?[i] as? NSManagedObject
                    if let accountDel = accountDel{
                        let name = accountDel.value(forKey: AccountContract.ColumnUsername.rawValue) as? String
                        if name == account.getUsername(){
                            AppDelegate.managedObjectContext?.delete(accountDel)
                            try AppDelegate.managedObjectContext?.save()
                        }
                    }
                }
            }
        } catch {
            return false
        }
        return false
    }
}
