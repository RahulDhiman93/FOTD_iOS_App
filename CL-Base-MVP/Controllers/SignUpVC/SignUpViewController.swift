//
//  SignUpViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 18/06/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var username : String?
    var email    : String?
    var password : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    class func initiate() -> SignUpViewController {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        return controller
    }
    
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.usernameTextField.resignFirstResponder()
        
        guard let username = self.username else {
            ErrorView.showWith(message: "Please enter your username", isErrorMessage: true) {
            }
            return
        }
        
        guard let email = self.email else {
            ErrorView.showWith(message: "Please enter your email", isErrorMessage: true) {
            }
            return
        }
        
        guard self.isValidEmail(testStr: email) else {
            ErrorView.showWith(message: "Please enter a valid email", isErrorMessage: true) {
            }
            return
        }
        
        guard let password = self.password else {
            ErrorView.showWith(message: "Please enter your password", isErrorMessage: true) {
            }
            return
        }
        
        let param: [String : Any] = [
            "user_name"    : username,
            "user_email"   : email,
            "password"     : password
        ]
        
        LoginManager.share.signUpFromEmail(param: param, callback: { response , error in
            
            guard response != nil, error == nil else {
                ErrorView.showWith(message: error?.localizedDescription ?? "Server Error, Please try again!", isErrorMessage: true) {
                }
                return
            }
            
            self.dismiss(animated: true) {
                ErrorView.showWith(message: "Please login now!", isErrorMessage: true) {
                }
            }
            
        })
        
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.usernameTextField {
            if textField.text!.isEmpty {
                self.username = nil
            } else {
                self.username = textField.text
            }
        } else if textField == self.emailTextField {
            if textField.text!.isEmpty {
                self.email = nil
            } else {
                self.email = textField.text
            }
        } else if textField == self.passwordTextField {
            if textField.text!.isEmpty {
                self.password = nil
            } else {
                self.password = textField.text
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
