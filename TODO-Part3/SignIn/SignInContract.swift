//
//  SignInContract.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/2/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

/*
 Presenter
 */
protocol SignInPresenter {
    func checkSignInAccount (username : String, password : String)
}

/*
 View
 */
protocol SignInView: class {
    func onSignInSuccess(username : String)
    func onSignInFail(err : String)
}
