//
//  OtpVerificationViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 27/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit
import PinCodeTextField

class OtpVerificationViewController: UIViewController {

    @IBOutlet weak var pinCodeFieldView: PinCodeTextField!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    var presenter : OtpVerificationPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.pinCodeFieldView.delegate = self
        self.pinCodeFieldView.keyboardType = .decimalPad
        
        if self.presenter.isComingFromMoreTab {
            self.backButton.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.presenter.verifyOtpWithServer()
    }
    
    @IBAction func backToLoginTapped(_ sender: UIButton) {
        guard let vc = LoginRouter.LoginVC() else { return }
        let navigationController = UINavigationController()
        navigationController.viewControllers = [vc]
        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            appDelegate.window?.rootViewController = navigationController
        }, completion: nil)
    }
    
}

extension OtpVerificationViewController : OtpVerificationPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func otpSuccess() {
        guard let accessToken = self.presenter.accessToken else { return }
        guard let vc = ResetPasswordRouter.ResetPasswordVC() else { fatalError() }
        vc.presenter = ResetPasswordPresenter(view: vc)
        vc.presenter.accessToken = accessToken
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension OtpVerificationViewController : PinCodeTextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: PinCodeTextField) -> Bool {
        return true
    }
    
    func textFieldValueChanged(_ textField: PinCodeTextField) {
        let value = textField.text ?? ""
        self.presenter.otp = value
    }
    
    func textFieldShouldEndEditing(_ textField: PinCodeTextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: PinCodeTextField) -> Bool {
        return true
    }
    
}
