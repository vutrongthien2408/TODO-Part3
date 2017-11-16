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
    var location: String
    
    init(accountName: String,
        categoryName: String,
        title: String,
        descriptions: String,
        time: String,
        location: String
        ) {
        self.accountName = accountName
        self.categoryName = categoryName
        self.title = title
        self.descriptions = descriptions
        self.time = time
        self.location = location
    }
    
}

extension Status {
    static let TableName = "TblStatus"
    static let ColumnCategoryName = "categoryName"
    static let ColumnAccountName = "accountName"
    static let ColumnTitle = "title"
    static let ColumnDescriptions = "descriptions"
    static let ColumnTime = "time"
    static let ColumnLocation = "location"
}
