//
//  NavigationPresenter.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/16/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class NavigationPresenter {
    
    var navigations: [String]
    
    init() {
        navigations = [String]()
        navigations.append("Home")
        navigations.append("Calendar")
        navigations.append("OverView")
        navigations.append("Groups")
        navigations.append("Profile")
        navigations.append("Timeline")
    }
}
