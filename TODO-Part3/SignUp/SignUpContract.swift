//
//  SignUpContract.swift
//  TODO-Part3
//
//  Created by Mac Pro on 10/27/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

/*
 Presenter
 */
protocol SignUpPresenter {
    func checkSignUpAccount(username: String, email: String, password: String, birthday: String)
}

/*
 View
 */
protocol SignUpView {
    func onInsertSuccess(username: String)
    func onInsertFail(err: String)
}
