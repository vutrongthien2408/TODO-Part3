//
//  CalendarContainerViewController.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/20/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class CalendarContainerViewController: UIViewController {

    private let statusInCalendarCellKey = "StatusInCalendarCell"
    private var statuses: [Status]?
    private var presenter: ProfilePresenter?
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
    
}

extension CalendarContainerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: statusInCalendarCellKey) as! ItemProfileCell
        cell.bind(status: statuses?[indexPath.row])
        return cell
    }
    
}
