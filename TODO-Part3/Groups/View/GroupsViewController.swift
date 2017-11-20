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

enum NavigarionMenuType: String {
    case home = "Home"
    case calendar = "Calendar"
    case overView = "OverView"
    case groups = "Groups"
    case lists = "Lists"
    case profile = "Profile"
    case timeLine = "Timeline"
}

class GroupsViewController: UIViewController {
    
    private var menuShowing = false
    private let timeToShowNavigation = 0.3
    private let navigationContraintShow: CGFloat = 0
    private let navigationContraintHide: CGFloat = -330
    private let navigationOpacity: Float = 1
    private let navigationShadow: CGFloat = 6
    
    private var categories: [CategoryObject]?
    private var presenter: CategoryPresenter?
    private let categoryCellKey = "CategoryCell"
    private let listViewControllerKey = "ListViewController"
    private let navigationCellKey = "NavigationMenuItem"
    private let profileViewControllerKey = "ProfileViewController"
    private let mainStoryboardKey = "Main"
    private var navigationPresenter: NavigationPresenter?
    private let goToCalendarIdentifier = "GoToCalendarIdentifier"
    
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
        navigationPresenter = NavigationPresenter()
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
        closeNavigationMenu()
    }
    
    func closeNavigationMenu() {
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
        if tableView == categoyTableView {
            return presenter?.categories.count ?? 0
        }
        return navigationPresenter?.navigations.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == categoyTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellKey) as! CategoryCell
            let rowData = presenter?.categories[indexPath.row]
            cell.bind(category: rowData)
                return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: navigationCellKey) as! NavigationCell
        let rowdata = navigationPresenter?.navigations[indexPath.row]
        cell.bind(navigationItem: rowdata)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == categoyTableView {
            categoryItemClick(row: indexPath.row)
        } else {
            navigationItemClick(row: indexPath.row)
        }
    }
    
    private func categoryItemClick(row: Int) {
        let rowData = presenter?.categories[row]
        let storyboard = UIStoryboard(name: mainStoryboardKey, bundle: nil)
        let listviewController =
            storyboard.instantiateViewController(withIdentifier: listViewControllerKey) as! ListViewController
        listviewController.category = rowData
        navigationController?.pushViewController(listviewController, animated: true)
    }
    
    private func navigationItemClick(row: Int) {
        let rowData = navigationPresenter?.navigations[row]
        let storyboard = UIStoryboard(name: mainStoryboardKey, bundle: nil)
        if rowData == NavigarionMenuType.profile.rawValue {
            let profileViewController =
                storyboard.instantiateViewController(withIdentifier: profileViewControllerKey) as! ProfileViewController
            navigationController?.pushViewController(profileViewController, animated: true)
        } else if rowData == NavigarionMenuType.home.rawValue {
            self.dismiss(animated: true, completion: nil)
        } else if rowData == NavigarionMenuType.calendar.rawValue {
            self.performSegue(withIdentifier: goToCalendarIdentifier, sender: nil)
        }
        closeNavigationMenu()
    }

}
