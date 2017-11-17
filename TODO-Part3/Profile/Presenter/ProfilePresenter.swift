//
//  ProfilePresenter.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/17/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class ProfilePresenter {
    private let data: StatusLocalDataImp
    
    init() {
        data = StatusLocalDataImp()
    }
    
    func getStatusByAccount(accountName: String) -> [Status]? {
        return data.getStatusByAccount(accountName: accountName)
    }
}
