//
//  CreateStatusViewController.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/13/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

enum TimeFormatStype: String {
    case timeStypeOne = "HH:mm"
    case timeStypeTwo = "mm:HH"
}

class CreateStatusViewController: UITableViewController {
    
    private var categoryNames = [String]()
    private let numberOfComponentPicker = 1
    private var presenter: CategoryPresenter?
    
    private var dateTime: String?
    private var statusTitle: String?
    private var descriptions: String?
    private var location: String?
    private var categoryName: String?
    private var accountName: String?

    @IBOutlet weak var txtTitle: HoshiTextField!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var txtLocation: HoshiTextField!
    @IBOutlet weak var pickerCategory: UIPickerView!
    @IBOutlet weak var pickerDate: UIDatePicker!
    @IBOutlet weak var pickerTime: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func prepare() {
        changeKeyboardType()
        presenter = CategoryPresenter()
        guard let categoryArr = presenter?.categories else {
            return
        }
        for category in categoryArr {
            categoryNames.append(category.title)
        }
        dateTime = "\(getDateFromPicker(date: pickerDate)) \(getDateFromPicker(date: pickerTime))"
        categoryName = categoryNames.first
    }
    
    func saveStatus() -> Status? {
        accountName = UserDefaults.standard.string(forKey: AccountContract.ColumnUsername.rawValue)
        if let accountName = accountName,
            let statusTitle = statusTitle,
            let descriptions = descriptions,
            let categoryName = categoryName,
            let dateTime = dateTime,
            let location = location {
                let status = Status(
                    accountName: accountName,
                    categoryName: categoryName,
                    title: statusTitle,
                    descriptions: descriptions,
                    time: dateTime,
                    location: location
                )
                return status
        }
        return nil
    }
    
    func getDateFromPicker(date: UIDatePicker) -> String {
        let dateFormatter = DateFormatter()
        if date == pickerDate {
            dateFormatter.dateFormat = DateFormatStyle.styleFour.rawValue
        } else {
            dateFormatter.dateFormat = TimeFormatStype.timeStypeOne.rawValue
        }
        let date = dateFormatter.string(from: date.date)
        return date
    }
    
    @IBAction func pickerChangeValue(_ sender: UIDatePicker) {
        dateTime = "\(getDateFromPicker(date: pickerDate)) \(getDateFromPicker(date: pickerTime))"
    }
    
}

extension CreateStatusViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponentPicker
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryName = categoryNames[row]
    }
    
}

extension CreateStatusViewController: UITextFieldDelegate, UITextViewDelegate {
    
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtTitle {
            statusTitle = txtTitle.text
        } else if textField == txtLocation {
            location = txtLocation.text
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        descriptions = tvDescription.text
    }
}
