//
//  StatusPresenterIpm.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/15/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class CreateStatusPresenterIpm: CreateStatusPresenter {
   
    private let data: StatusDataContract
    private weak var view: StatusView?
    private var err = "Not status data"
    private var msg = "Insert success"
    
    init(view: StatusView) {
        self.view = view
        data = StatusLocalDataImp()
    }
    
    func insertStatus(acoountName: String, categoryName: String, title: String, descriptions: String, time: String, location: String) {
        let status = Status(
            accountName: acoountName,
            categoryName: categoryName,
            title: title,
            descriptions: descriptions,
            time: time,
            location: location
        )
        if data.insertStatus(status: status) {
            view?.onInsertStatusSuccess(mgs: msg)
        } else {
            view?.onInsertStatusfail(err: err)
        }
    }
}
