//
//  ProfileViewController.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/17/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var statuses: [Status]?
    private var presenter: ProfilePresenter?
    private let itemProfileCellKey = "ItemProfileCell"
    private let mainStoryboardKey = "Main"
    private let settingViewControllerKey = "SettingViewController"

    @IBOutlet weak var tableStatus: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepare() {
        statuses = [Status]()
        presenter = ProfilePresenter()
        if let accountName =
            UserDefaults.standard.string(forKey: AccountContract.ColumnUsername.rawValue) {
            statuses = presenter?.getStatusByAccount(accountName: accountName)
        }
    }
    
    @IBAction func editProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: mainStoryboardKey, bundle: nil)
        let settingViewController =
            storyboard.instantiateViewController(withIdentifier: settingViewControllerKey) as! SettingViewController
        navigationController?.pushViewController(settingViewController, animated: true)
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemProfileCellKey) as! ItemProfileCell
        cell.bind(status: statuses?[indexPath.row])
        return cell
    }
    
}
