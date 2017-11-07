//
//  TblAccount.swift
//  TODO-Part3
//
//  Created by Mac Pro on 10/27/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import CoreData

class Account {
    
    var username: String
    var email: String
    var password: String
    var birthday: String

    init(username: String, email: String, password: String, birthday: String) {
        self.username = username
        self.email = email
        self.password = password
        self.birthday = birthday
    }

}

enum AccountContract: String {
    case TableName = "TblAccount"
    case ColumnId  = "id"
    case ColumnUsername = "username"
    case ColumnEmail  = "email"
    case ColumnPassword = "password"
    case ColumnBirthday  = "birthday"
}

