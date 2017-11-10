//
//  CategoryObject.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/13/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class CategoryObject {
    
    var title: String
    var description: String
    var imageName: String
    
    init(title: String, description: String, imageName: String) {
        self.title = title
        self.description = description
        self.imageName = imageName
    }
}
