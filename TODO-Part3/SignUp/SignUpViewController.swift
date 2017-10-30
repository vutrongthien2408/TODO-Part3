//
//  SignUpViewController.swift
//  TODO-Part3
//
//  Created by vu trong thien on 10/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate,SignUpView{

    static let SignUp = "Sign up"
    var presenter: SignUpPresenter?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtUsername: HoshiTextField!
    @IBOutlet weak var txtEmail: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var txtBirthday: HoshiTextField!
    @IBAction func cancleSignUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSignUp(_ sender: Any) {
        let username = txtUsername.text
        let email = txtEmail.text
        let password = txtPassword.text
        let birthday = txtBirthday.text
        if let username = username, let email = email, let password = password, let birthday = birthday  {
            if (username == "") || email == "" || password == "" || birthday == "" {
                let alert =  UIAlertController(title: SignUpViewController.SignUp, message: "not data", preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }else{
                presenter?.checkSignUpAccount(username: username, email: email, password: password, birthday: birthday)
            }
        }else {
            return
        }
    }
    
    func onInsertSuccess(username: String) {
        let alert =  UIAlertController(title: SignUpViewController.SignUp, message: "SignUp Success", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        // change screen to login
    }
    
    func onInsertFail(err: String) {
        let alert =  UIAlertController(title: SignUpViewController.SignUp, message: err, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Again", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeKeyBoardType() {
        txtUsername.returnKeyType = UIReturnKeyType.next
        txtEmail.returnKeyType = UIReturnKeyType.next
        txtPassword.returnKeyType = UIReturnKeyType.next
        txtBirthday.returnKeyType = UIReturnKeyType.done
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var y = 0
        if textField == txtEmail {
            y = 50
        }else if textField == txtPassword{
            y = 100
        }else if textField == txtBirthday{
            y = 200
        }
        let cg = CGPoint.init(x: 0, y: y)
        scrollView.setContentOffset(cg, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField == txtBirthday {
            scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtBirthday {
            txtBirthday.resignFirstResponder()
            return true
        }else if textField == txtUsername {
            txtEmail.becomeFirstResponder()
        }else if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        }else {
            txtBirthday.becomeFirstResponder()
        }
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        changeKeyBoardType()
        presenter = SignUpPresenterImp(view: self)
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
