//
//  BaseLocalData.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/1/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import CoreData
class BaseLocalData{
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
    let managedObjet = AppDelegate.managedObjectContext
}
