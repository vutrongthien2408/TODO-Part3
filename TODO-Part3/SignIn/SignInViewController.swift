//
//  SignInViewController.swift
//  TODO-Part3
//
//  Created by vu trong thien on 10/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    private let signInToSignUpIdentifier = "SignInToSignUp"
    private let signInToHomeIdentifier = "SignInToHome"
    
    @IBOutlet weak var txtUsername: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldSetKeyBoardType()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func btnSignUp(_ sender: Any) {
        dismiss(animated: true) {
            self.performSegue(withIdentifier: self.signInToSignUpIdentifier, sender: nil)
        }
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        // if login success ==> go to home screen
        performSegue(withIdentifier: signInToHomeIdentifier, sender: nil)
    }

}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtUsername {
            txtPassword.becomeFirstResponder()
        } else {
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
        var bottomPadding = 0
        if textField == txtUsername {
            bottomPadding = TextFieldBottomPadding.username.rawValue
        } else if textField == txtPassword{
            bottomPadding = TextFieldBottomPadding.password.rawValue
        }
        let cg = CGPoint(x: 0, y: bottomPadding)
        scrollView.setContentOffset(cg, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField == txtPassword {
            scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }
    }
}
