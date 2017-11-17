//
//  NavigationCell.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/16/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class NavigationCell: UITableViewCell {

    @IBOutlet weak var txtNavigationItem: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        txtNavigationItem.text = nil
    }

    func bind(navigationItem: String?) {
        txtNavigationItem.text = navigationItem
    }
}
