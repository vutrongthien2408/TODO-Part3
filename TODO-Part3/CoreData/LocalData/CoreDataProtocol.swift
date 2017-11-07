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
    func insertAccount(account: Account) -> Bool
    func updateAccount(account: Account) -> Bool
    func deleteAccount(account: Account) -> Bool
}
