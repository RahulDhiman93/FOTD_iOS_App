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
        self.pinCodeFieldView.delegate = self
        self.pinCodeFieldView.keyboardType = .decimalPad
        
        if self.presenter.isComingFromMoreTab {
            self.backButton.setTitle("Back to profile", for: .normal)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.presenter.isComingFromMoreTab {
            self.navigationController?.isNavigationBarHidden = false
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.presenter.verifyOtpWithServer()
    }
    
    @IBAction func backToLoginTapped(_ sender: UIButton) {
        
        if self.presenter.isComingFromMoreTab {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
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
