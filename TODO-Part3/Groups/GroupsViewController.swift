//
//  GroupsViewController.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/9/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController {
    
    private var menuShowing = false
    private let timeToShowNavigation = 0.3
    private let navigationContraintShow: CGFloat = 0
    private let navigationContraintHide: CGFloat = -330
    private let navigationOpacity: Float = 1
    private let navigationShadow: CGFloat = 6
    
    @IBOutlet weak var contraintLeading: NSLayoutConstraint!
    @IBOutlet weak var navigationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.layer.shadowOpacity = navigationOpacity
        navigationView.layer.shadowRadius = navigationShadow
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func openMenu(_ sender: Any) {
        if menuShowing {
            contraintLeading.constant = navigationContraintHide
        } else {
            contraintLeading.constant = navigationContraintShow
        }
        UIView.animate(withDuration: timeToShowNavigation) {
            self.view.layoutIfNeeded()
        }
        menuShowing = !menuShowing
    }
    
}
