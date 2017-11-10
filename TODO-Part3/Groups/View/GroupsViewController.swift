//
//  GroupsViewController.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/9/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

enum CategoryType: String {
    case food = "Food"
    case work = "Work"
    case vacation = "Vacation"
    case cities = "Cities"
}

class GroupsViewController: UIViewController {
    
    private var menuShowing = false
    private let timeToShowNavigation = 0.3
    private let navigationContraintShow: CGFloat = 0
    private let navigationContraintHide: CGFloat = -330
    private let navigationOpacity: Float = 1
    private let navigationShadow: CGFloat = 6
    
    private var categories: [Category]?
    private var presenter: CategoryPresenter?
    
    @IBOutlet weak var contraintLeading: NSLayoutConstraint!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var categoyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepare() {
        navigationView.layer.shadowOpacity = navigationOpacity
        navigationView.layer.shadowRadius = navigationShadow
        prepareSwips()
        presenter = CategoryPresenter()
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
    
    @IBAction func createStatus(_ sender: Any) {
        self.performSegue(withIdentifier: "GroupsToCreateStatus", sender: nil)
    }
    
    func prepareSwips() {
        let swipFromRight = UISwipeGestureRecognizer(target: self, action: #selector (self.leftSwiping(gesture:)))
        swipFromRight.direction = .left
        view.addGestureRecognizer(swipFromRight)
    }
    
    @objc func leftSwiping(gesture:UIGestureRecognizer) {
        if menuShowing {
            contraintLeading.constant = navigationContraintHide
        }
        UIView.animate(withDuration: timeToShowNavigation) {
            self.view.layoutIfNeeded()
        }
        menuShowing = !menuShowing
    }
    
}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        let rowData = presenter?.categories[indexPath.row]
        cell.bind(category: rowData)
        return cell
    }

}
