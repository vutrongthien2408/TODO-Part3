//
//  SettingProtocol.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/17/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol SettingPresenter {
    
    func updateAccount(account: Account, currentUsername: String)
    func getAccountDetail(username: String) -> Account?
    
}

protocol SettingView: class {
    
    func onUpdateAccountSuccess(msg: String)
    func onUpdateAccountFail(err: String)
    
}
