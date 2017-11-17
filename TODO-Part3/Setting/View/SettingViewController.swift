//
//  SettingViewController.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/17/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    private var settingTableView: SettingTableViewController?
    private let settingEmbedSegueKey = "SettingEmbedSegue"
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == settingEmbedSegueKey {
            settingTableView = segue.destination as! SettingTableViewController
        }
    }
    
    @IBAction func updateAccount(_ sender: Any) {
        settingTableView?.updateAccount()
    }
}
