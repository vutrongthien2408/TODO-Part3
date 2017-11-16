//
//  StatusProtocol.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/15/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol CreateStatusPresenter{
    
    func insertStatus(
        acoountName: String,
        categoryName: String,
        title: String,
        descriptions: String,
        time: String,
        location: String
    )
    
}

protocol StatusView: class {
    
    func onInsertStatusSuccess(mgs: String)
    func onInsertStatusfail(err: String)
    
}
