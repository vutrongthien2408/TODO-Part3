//
//  StatusCell.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/16/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {

    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var txtStatusTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgStatus.image = nil
        txtStatusTitle.text = nil
    }
    
    func bind(statusTitle: String) {
        txtStatusTitle.text = statusTitle
    }
}
