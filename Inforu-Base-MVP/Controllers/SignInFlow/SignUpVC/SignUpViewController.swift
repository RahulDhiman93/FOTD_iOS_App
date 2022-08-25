//
//  SignUpViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 18/06/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var presenter : SignUpPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = SignUpPresenter(view: self)
        self.usernameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.presenter.signUpFromEmail()
        
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SignUpViewController : SignUpPresenterDelegate {
   
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func SignUpSuccess() {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "AppBaseViewController") as? AppBaseViewController else { fatalError("TabBar Instance failed") }
       UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            appDelegate.window?.rootViewController = vc
        }, completion: nil)
    }
    
}

extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.usernameTextField {
            if textField.text!.isEmpty {
                self.presenter.username = nil
            } else {
                self.presenter.username = textField.text
            }
        } else if textField == self.emailTextField {
            if textField.text!.isEmpty {
                self.presenter.email = nil
            } else {
                self.presenter.email = textField.text
            }
        } else if textField == self.passwordTextField {
            if textField.text!.isEmpty {
                self.presenter.password = nil
            } else {
                self.presenter.password = textField.text
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
