//
//  ListPresenterIpm.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/15/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class ListPresenter {
    
    private let data: StatusDataContract
    
    init() {
        data = StatusLocalDataImp()
    }
    
    func loadStatusByCategoryAndAccount(categoryName: String, accountName: String) -> [Status]? {
        if let statuses = data.getStatusByCategoryAndAccount(
            categoryName: categoryName,
            accountName: accountName
            ) {
            return statuses
        }
        return nil
    }
}
