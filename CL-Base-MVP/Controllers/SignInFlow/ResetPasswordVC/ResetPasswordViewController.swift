//
//  ResetPasswordViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 27/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var presenter : ResetPasswordPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.presenter.resetPassword()
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        guard let navigationController = self.navigationController else { fatalError() }
        
        for viewController in navigationController.viewControllers {
            if viewController is LoginViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
        
    }
}

extension ResetPasswordViewController : ResetPasswordPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func resetPasswordSuccess() {
        
        let message = "password upated successfully, please login with your new credentials"
        ErrorView.showWith(message: message, isErrorMessage: true) {}
        
        guard let navigationController = self.navigationController else { fatalError() }
        
        for viewController in navigationController.viewControllers {
            if viewController is LoginViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
        
    }
}

extension ResetPasswordViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.passwordTextField {
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
