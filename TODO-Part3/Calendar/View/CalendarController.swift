//
//  ViewController.swift
//  myCalender2
//
//  Created by Muskan on 10/22/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import UIKit

enum MyTheme {
    
    case light
    case dark
    
}

class CalendarController: UIViewController {
    
    var theme = MyTheme.light
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Calender"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = Style.bgColor
        
        view.addSubview(calenderView)
        calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        calenderView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    let calenderView: CalenderView = {
        let v = CalenderView(theme: MyTheme.light)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
}

