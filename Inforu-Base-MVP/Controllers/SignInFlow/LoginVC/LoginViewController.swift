//
//  LoginViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 18/06/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logInButtonView: UIView!
    @IBOutlet weak var guestButtonView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var presenter : LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.presenter = LoginPresenter(view: self)
        self.logInButtonView.clipsToBounds = false
        self.guestButtonView.clipsToBounds = false
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        guard let vc = ForgotPasswordRouter.ForgotPasswordVC() else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func logInTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.presenter.loginFromEmail()
    }
    
    @IBAction func guestLoginTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        let distinctId = UIDevice.current.identifierForVendor?.uuidString ?? "n/a"
        self.presenter.guestLogin(distinctId: distinctId)
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let vc = SignUpRouter.SignUpVC() else { return }
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension LoginViewController : LoginPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func loginSuccess() {
        let sb = UIStoryboard(name: "Home", bundle: nil)
         guard let vc = sb.instantiateViewController(withIdentifier: "AppBaseViewController") as? AppBaseViewController else { fatalError("TabBar Instance failed") }
        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
             appDelegate.window?.rootViewController = vc
         }, completion: nil)
    }
}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
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


