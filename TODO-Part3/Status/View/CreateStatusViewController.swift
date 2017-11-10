//
//  CreateStatusViewController.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/13/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class CreateStatusViewController: UITableViewController {
    
    private let categoryName = [
        CategoryType.food.rawValue,
        CategoryType.work.rawValue,
        CategoryType.vacation.rawValue,
        CategoryType.cities.rawValue
    ]
    private let numberOfComponentPicker = 1

    @IBOutlet weak var txtTitle: HoshiTextField!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var txtLocation: HoshiTextField!
    @IBOutlet weak var pickerCategory: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeKeyboardType()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension CreateStatusViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponentPicker
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryName[row]
    }
    
}

extension CreateStatusViewController: UITextFieldDelegate {
    
    func changeKeyboardType() {
        txtTitle.returnKeyType = UIReturnKeyType.next
        txtLocation.returnKeyType = UIReturnKeyType.done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == txtTitle {
            tvDescription.becomeFirstResponder()
            return true
        }
        return false
    }
}
