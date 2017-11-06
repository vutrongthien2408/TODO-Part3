//
//  SignUpPresenterIpm.swift
//  TODO-Part3
//
//  Created by Mac Pro on 10/27/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class SignUpPresenterImp: SignUpPresenter {
    
    private let data: AccountDataContract
    weak private var view: SignUpView?
    
    init(view: SignUpView) {
        data = AccountLocalData()
        self.view = view
    }
    
    func checkSignUpAccount(username: String, email: String, password: String, birthday: String) {
        let account = Account(username: username, email: email, password: password, birthday: birthday)
        if data.checkAccountByName(username: username)
            || data.checkAccountByEmail(email: email) {
            view?.onInsertFail(err: SignUpResult.accountAlreadyExist.rawValue)
        } else {
            if data.insertAccount(account: account) {
                view?.onInsertSuccess(username: username)
            } else {
                view?.onInsertFail(err: SignUpResult.signUpfail.rawValue)
            }
        }
    }
}
