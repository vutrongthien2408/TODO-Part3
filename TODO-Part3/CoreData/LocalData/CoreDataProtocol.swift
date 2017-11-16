//
//  CoreDataProtocol.swift
//  TODO-Part3
//
//  Created by Mac Pro on 10/30/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
protocol AccountDataContract {
    func getAllAccount() -> [Account]?
    func checkAccountByName(username: String) -> Bool
    func checkAccountByEmail(email: String) -> Bool
    func checkSignInAccount(username: String, password: String) -> Bool
    func insertAccount(account: Account) -> Bool
    func updateAccount(account: Account) -> Bool
    func deleteAccount(account: Account) -> Bool
}

protocol StatusDataContract {
    func getStatusByAccount(accountName: String) -> [Status]?
    func getStatusByCategoryAndAccount(categoryName: String, accountName: String) -> [Status]?
    func insertStatus(status: Status) -> Bool
    func updateStatus(status: Status) -> Bool
    func deleteStatus(status: Status) -> Bool
}
