//
//  SignInViewController.swift
//  TODO-Part3
//
//  Created by vu trong thien on 10/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtUsername: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    static let SignInToSignUpIdentifier = "SignInToSignUp"
    static let SignInToHomeIdentifier = "SignInToHome"
    @IBAction func btnSignUp(_ sender: Any) {
        dismiss(animated: true) {
             self.performSegue(withIdentifier: SignInViewController.SignInToSignUpIdentifier, sender: nil)
        }
    }
    @IBAction func btnSignIn(_ sender: Any) {
        // if login success ==> go to home screen
        performSegue(withIdentifier: SignInViewController.SignInToHomeIdentifier, sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtUsername {
            txtPassword.becomeFirstResponder()
        }else {
            txtPassword.resignFirstResponder()
            return true
        }
        return false
    }
    
    func textFieldSetKeyBoardType(){
        txtUsername.returnKeyType = UIReturnKeyType.next
        txtPassword.returnKeyType = UIReturnKeyType.done
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var y = 0
        if textField == txtUsername {
            y = 100
        }else if textField == txtPassword{
            y = 150
        }
        let cg = CGPoint.init(x: 0, y: y)
        scrollView.setContentOffset(cg, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField == txtPassword {
            scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldSetKeyBoardType()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
