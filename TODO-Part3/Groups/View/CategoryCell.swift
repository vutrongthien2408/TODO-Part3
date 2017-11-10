//
//  CategoryCell.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var txtCategoryTitle: UILabel!
    @IBOutlet weak var txtCategorySubtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        txtCategorySubtitle.text = nil
        txtCategoryTitle.text = nil
        categoryImage.image = nil
    }
    
    func bind(category: CategoryObject?) {
        guard let category = category else {
            return
        }
        txtCategorySubtitle.text = category.description
        txtCategoryTitle.text = category.title
        categoryImage.image = UIImage(named: category.imageName)
    }
    
}
