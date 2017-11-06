//
//  SignInPresenterIpm.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/2/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class SignInPresenterIpm: SignInPresenter {
    
    private let data: AccountDataContract
    weak private var view: SignInView?
    
    init(view : SignInView) {
        self.view = view
        data = AccountLocalData()
    }
    
    func checkSignInAccount(username: String, password: String) {
        if data.checkSignInAccount(username: username, password: password) {
            view?.onSignInSuccess(username: username)
        } else {
            view?.onSignInFail(err: SignInResult.signInFail.rawValue)
        }
    }
}
