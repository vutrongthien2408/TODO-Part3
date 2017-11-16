//
//  CreateContainerViewController.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class CreateContainerViewController: UIViewController {
    
    private var statusTitle: String?
    private var descriptions: String?
    private var location: String?
    private var time: String?
    private var categoryName: String?
    private var accountName: String?
    
    private var createStatusViewController: CreateStatusViewController?
    private var presenter: CreateStatusPresenter?
    private var createStatusKey = "Create status"
    private var createEmbedSegueKey = "CreateEmbedSegue"
    
    @IBAction func btnCreate(_ sender: Any) {
        let status = createStatusViewController?.saveStatus()
        if let status = status {
            presenter?.insertStatus(
                acoountName: status.accountName,
                categoryName: status.categoryName,
                title: status.title,
                descriptions: status.descriptions,
                time: status.time,
                location: status.location
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    private func prepare() {
        presenter = CreateStatusPresenterIpm(view: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == createEmbedSegueKey {
            createStatusViewController = segue.destination as! CreateStatusViewController
        }
    }

}

extension CreateContainerViewController: StatusView {
    
    func onInsertStatusSuccess(mgs: String) {
        let alert =  UIAlertController(
            title: createStatusKey,
            message: mgs,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let cancelAction = UIAlertAction(title: ButtonTitle.ok.rawValue, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func onInsertStatusfail(err: String) {
        let alert =  UIAlertController(
            title: createStatusKey,
            message: err,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let cancelAction = UIAlertAction(title: ButtonTitle.again.rawValue, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}
