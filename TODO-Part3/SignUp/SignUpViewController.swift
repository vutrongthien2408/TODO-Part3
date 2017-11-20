//
//  SignUpViewController.swift
//  TODO-Part3
//
//  Created by vu trong thien on 10/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

enum TextFieldBottomPadding: Int {
    case email = 50
    case username = 150
    case password = 100
    case birthday = 200
}

enum SignUpResult: String {
    case empty = "Not data"
    case signUpfail = "SignUp fail"
    case accountAlreadyExist = "Username or email is already exists"
    case signUpSuccess = "SignUp success"
}

enum ButtonTitle: String {
    case ok = "Ok"
    case cancle = "Cancle"
    case again = "Again"
}

enum DateFormatStyle: String {
    case styleOne = "dd/MM/yyyy"
    case styleTwo = "MM/dd/yyyy"
    case styleThree = "dd/MM/yy"
    case styleFour = "MM/dd/yy"
    case styleFive = "yyyy/MM/dd"
}

class SignUpViewController: UIViewController {

    private let signUpKey = "Sign up"
    private let signUpToHomeIdentifier = "SignUpToHome"
    private var presenter: SignUpPresenter?
    
    @IBOutlet weak var lbBirthday: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtUsername: HoshiTextField!
    @IBOutlet weak var txtEmail: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var txtBirthday: HoshiTextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeKeyBoardType()
        presenter = SignUpPresenterImp(view: self)
        datePicker.datePickerMode = .date
        datePicker.isHidden = true
        lbBirthday.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getBirthdayFromDatePicker(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = DateFormatStyle.styleOne.rawValue
        return dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func cancleSignUp(_ sender: Any) {
        presenter = nil
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        let username = txtUsername.text
        let email = txtEmail.text
        let password = txtPassword.text
        let birthday = txtBirthday.text
        if let username = username, !username.isEmpty,
            let email = email, !email.isEmpty,
            let password = password, !password.isEmpty,
            let birthday = birthday, !birthday.isEmpty {
            presenter?.checkSignUpAccount(username: username, email: email,
                                          password: password, birthday: birthday)
        } else {
            let alert =  UIAlertController(title: signUpKey, message: SignUpResult.empty.rawValue,
                                           preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: ButtonTitle.again.rawValue,
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
}

extension SignUpViewController: SignUpView {
    
    func onInsertSuccess(username: String) {
        UserDefaults.standard.set(
            username,
            forKey: AccountContract.ColumnUsername.rawValue
        )
        let alert =  UIAlertController(
            title: signUpKey,
            message: SignUpResult.signUpSuccess.rawValue,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let cancelAction = UIAlertAction(title: ButtonTitle.ok.rawValue, style: .cancel) { (action) in
            self.presenter = nil
            self.performSegue(withIdentifier: self.signUpToHomeIdentifier, sender: nil)
        }
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func onInsertFail(err: String) {
        let alert =  UIAlertController(
            title: signUpKey,
            message: err,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let cancelAction = UIAlertAction(title: ButtonTitle.again.rawValue, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func changeKeyBoardType() {
        txtUsername.returnKeyType = UIReturnKeyType.next
        txtEmail.returnKeyType = UIReturnKeyType.next
        txtPassword.returnKeyType = UIReturnKeyType.next
        txtBirthday.returnKeyType = UIReturnKeyType.done
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var bottompadding = 0
        if textField == txtEmail {
            bottompadding = TextFieldBottomPadding.email.rawValue
        } else if textField == txtPassword {
            bottompadding = TextFieldBottomPadding.password.rawValue
        } else if textField == txtBirthday {
            txtBirthday.isHidden = true
            datePicker.isHidden = false
            lbBirthday.isHidden = false
            bottompadding = TextFieldBottomPadding.birthday.rawValue
        }
        let cg = CGPoint(x: 0, y: bottompadding)
        scrollView.setContentOffset(cg, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField == txtBirthday {
            scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            txtBirthday.isHidden = false
            datePicker.isHidden = true
            lbBirthday.isHidden = true
            txtBirthday.text = getBirthdayFromDatePicker(date: datePicker.date)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtBirthday {
            txtBirthday.text =  getBirthdayFromDatePicker(date: datePicker.date)
            txtBirthday.resignFirstResponder()
            return true
        } else if textField == txtUsername {
            txtEmail.becomeFirstResponder()
        } else if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        } else {
            txtBirthday.becomeFirstResponder()
        }
        return false
    }
}
