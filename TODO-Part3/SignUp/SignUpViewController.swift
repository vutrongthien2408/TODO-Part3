//
//  SignUpViewController.swift
//  TODO-Part3
//
//  Created by vu trong thien on 10/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtUsername: HoshiTextField!
    @IBOutlet weak var txtEmail: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var txtBirthday: HoshiTextField!
    @IBAction func cancleSignUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSignUp(_ sender: Any) {
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
       
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
