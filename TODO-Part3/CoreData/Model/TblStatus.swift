//
//  TblStatus.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/10/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class Status {
    
    var accountName: String
    var categoryName: String
    var title: String
    var descriptions: String
    var time: String
    
    init(accountName: String, categoryName: String, title: String, descriptions: String, time: String) {
        self.accountName = accountName
        self.categoryName = categoryName
        self.title = title
        self.descriptions = descriptions
        self.time = time
    }
    
}

extension Status {
    static let TableName = "TblStatus"
    static let ColumnCategoryName = "categoryName"
    static let ColumnAccountName = "accountName"
    static let ColumnTitle = "title"
    static let ColumnDescriptions = "descriptions"
    static let ColumnTime = "time"
}
