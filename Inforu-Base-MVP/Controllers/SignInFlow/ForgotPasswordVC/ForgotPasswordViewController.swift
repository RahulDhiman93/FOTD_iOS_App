//
//  ForgotPasswordViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 19/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var bottomShape: UIView!
    
    var presenter : ForgotPasswordPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ForgotPasswordPresenter(view: self)
        self.emailAddressTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.presenter.sendForgotPasswordEmail()
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.bottomShape.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ForgotPasswordViewController : ForgotPasswordPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func emailSuccess() {
        guard let vc = OtpVerificationRouter.OtpVerificationVC() else { fatalError() }
        vc.presenter = OtpVerificationPresenter(view: vc)
        vc.presenter.email = self.presenter.email
        self.navigationController?.pushViewController(vc, animated: true)
    }
       
}

extension ForgotPasswordViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard !textField.text!.isEmptyOrWhitespace() else {
            self.failure(message: "Please type a email first")
            return
        }
        self.presenter.email = textField.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailAddressTextField.resignFirstResponder()
        return true
    }
}
