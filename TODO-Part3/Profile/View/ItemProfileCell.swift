//
//  ItemProfileCell.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/17/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ItemProfileCell: UITableViewCell {

    @IBOutlet weak var txtStatusTitle: UILabel!
    @IBOutlet weak var txtStatusSubtitle: UILabel!
    @IBOutlet weak var txtStatusTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        txtStatusTime.text = nil
        txtStatusTitle.text = nil
        txtStatusSubtitle.text = nil
    }
    
    func bind(status: Status?) {
        txtStatusTitle.text = status?.title
        txtStatusSubtitle.text = status?.descriptions
        txtStatusTime.text = status?.time
    }

}
