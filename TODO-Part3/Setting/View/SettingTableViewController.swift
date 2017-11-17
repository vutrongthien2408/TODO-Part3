//
//  SettingTableViewController.swift
//  TODO-Part3
//
//  Created by Mac Pro on 11/17/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    private let updateKey = "Update account"
    private var presenter: SettingPresenter?
    private var currentUsername: String?
    var account: Account?
    
    @IBOutlet weak var txtUsername: HoshiTextField!
    @IBOutlet weak var txtEmail: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var txtBirthday: HoshiTextField!
    @IBOutlet weak var lbBirthday: UILabel!
    @IBOutlet weak var pickerBirthday: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func prepare() {
        changeKeyBoardType()
        presenter = SettingPresenterIpm(view: self)
        currentUsername = UserDefaults.standard.string(forKey: AccountContract.ColumnUsername.rawValue)
        if let currentUsername = currentUsername {
            account = presenter?.getAccountDetail(username: currentUsername)
            txtUsername.text = account?.username
            txtEmail.text = account?.email
            txtPassword.text = account?.password
            txtBirthday.text = account?.birthday
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        hidePickerBirthday()
    }
    
    func updateAccount() {
        if let usernamme = txtUsername.text,
            let email = txtEmail.text,
            let password = txtPassword.text,
            let birthday = txtBirthday.text,
            let currentUsername = currentUsername {
                let newAccount = Account(username: usernamme, email: email, password: password, birthday: birthday)
                presenter?.updateAccount(account: newAccount, currentUsername: currentUsername)
            }
    }
    
    private func getBirthdayFromDatePicker(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = DateFormatStyle.styleOne.rawValue
        return dateFormatter.string(from: pickerBirthday.date)
    }
    
}

extension SettingTableViewController: SettingView {
    
    func onUpdateAccountSuccess(msg: String) {
        UserDefaults.standard.set(
            txtUsername.text,
            forKey: AccountContract.ColumnUsername.rawValue
        )
        let alert =  UIAlertController(
            title: updateKey,
            message: msg,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let cancelAction = UIAlertAction(title: ButtonTitle.ok.rawValue, style: .cancel, handler: { action in
            self.navigationController?.popToRootViewController(animated: true)
        })
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func onUpdateAccountFail(err: String) {
        let alert =  UIAlertController(
            title: updateKey,
            message: err,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let cancelAction = UIAlertAction(title: ButtonTitle.again.rawValue, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension SettingTableViewController: UITextFieldDelegate {
    
    func changeKeyBoardType() {
        txtUsername.returnKeyType = UIReturnKeyType.next
        txtEmail.returnKeyType = UIReturnKeyType.next
        txtPassword.returnKeyType = UIReturnKeyType.next
        txtBirthday.returnKeyType = UIReturnKeyType.done
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtBirthday {
           showPickerBirthday()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtBirthday {
            txtBirthday.resignFirstResponder()
            txtBirthday.text = getBirthdayFromDatePicker(date: pickerBirthday.date)
            hidePickerBirthday()
            return true
        } else if textField == txtUsername {
            txtEmail.becomeFirstResponder()
        } else if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        } else {
            txtBirthday.becomeFirstResponder()
            showPickerBirthday()
        }
        return false
    }
    
    func showPickerBirthday() {
        txtBirthday.isHidden = true
        lbBirthday.isHidden = false
        pickerBirthday.isHidden = false
    }
    
    func hidePickerBirthday() {
        txtBirthday.isHidden = false
        lbBirthday.isHidden = true
        pickerBirthday.isHidden = true
    }
    
}
