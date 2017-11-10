//
//  CategoryPresenter.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/13/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class CategoryPresenter {
  
    var categories: [CategoryObject]
    
    init() {
        categories = [CategoryObject]()
        categories.append(CategoryObject(title: "Food", description: "NEED TO BUY", imageName: "food.png"))
        categories.append(CategoryObject(title: "Work", description: "FREELANCE PROJECTS", imageName: "work.png"))
        categories.append(CategoryObject(title: "Vacation", description: "FAVORITE PLACES", imageName: "vacation.png"))
        categories.append(CategoryObject(title: "Cities", description: "WANT TO VISIT", imageName: "vacation.png"))
    }
    
}
