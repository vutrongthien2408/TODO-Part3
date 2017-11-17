//
//  SettingPresenter.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/17/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class SettingPresenterIpm: SettingPresenter {
    
    private let data: AccountLocalData
    private weak var view: SettingView?
    private let updateSuccessKey = "Update Success"
    private let updateFailKey = "Update fail"
    
    init(view: SettingView) {
        data = AccountLocalData()
        self.view = view
    }
    
    func getAccountDetail(username: String) -> Account? {
        return data.getAccountDetailByName(username: username)
    }
    
    func updateAccount(account: Account, currentUsername: String) {
        if data.updateAccount(account: account, currentUsername: currentUsername) {
            view?.onUpdateAccountSuccess(msg: updateSuccessKey)
        } else {
            view?.onUpdateAccountFail(err: updateFailKey)
        }
    }
    
}
