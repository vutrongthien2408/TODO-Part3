//
//  LoadViewController.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/15/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    private var presenter: ListPresenter?
    private var accountName: String?
    private var categoryName: String?
    private var statuses: [Status]?
    private let statusCellKey = "StatusCell"
    private let loadStatusKey = "LoadStatus"
    private var categories: CategoryPresenter?
    var category: CategoryObject?

    @IBOutlet weak var tableStatus: UITableView!
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var txtHeaderTitle: UILabel!
    @IBOutlet weak var txtHeaderSubtitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func prepare() {
        presenter = ListPresenter()
        statuses = [Status]()
        categories = CategoryPresenter()
        accountName = UserDefaults.standard.string(forKey: AccountContract.ColumnUsername.rawValue)
        categoryName = category?.title
        if let categoryName = categoryName, let accountName = accountName {
           statuses = presenter?.loadStatusByCategoryAndAccount(
            categoryName: categoryName,
            accountName: accountName
            )
        }
        updateHeader()
    }
    
    private func updateHeader() {
        guard let imageName = category?.imageName else {
            return
        }
        imgHeader.image = UIImage(named: imageName)
        txtHeaderTitle.text = category?.title
        txtHeaderSubtitle.text = category?.description
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableStatus.dequeueReusableCell(withIdentifier: statusCellKey) as! StatusCell
        if let statuses = statuses {
            let rowData = statuses[indexPath.row]
            cell.bind(statusTitle: rowData.title)
        }
        return cell
    }
    
}
