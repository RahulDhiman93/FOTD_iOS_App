//
//  LoginPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 17/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation

protocol LoginPresenterDelegate : AnyObject {
    func failure(message: String)
    func loginSuccess()
}

class LoginPresenter {
    
    weak var view  : LoginPresenterDelegate?
    var email    : String?
    var password : String?
    
    init(view: LoginPresenterDelegate) {
        self.view = view
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func loginFromEmail() {
        
        guard let email = self.email else {
            self.view?.failure(message: "Please enter your email")
            return
        }
        
        guard self.isValidEmail(testStr: email) else {
            self.view?.failure(message: "Please enter a valid email")
            return
        }
        
        guard let password = self.password else {
            self.view?.failure(message: "Please enter your password")
            return
        }
        
        let param : [String : Any] = [
            "email": email,
            "password": password,
            "device_token": AppConstants.deviceToken,
            "device_type": AppConstants.deviceType,
            "device_name": AppConstants.deviceName
        ]
        
        LoginManager.share.loginFromEmail(param: param, callback: { [weak self] response , error in
            
            
            guard response != nil, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            FirebaseEvents.loginEvent()
            self?.view?.loginSuccess()
            
            
        })
    }
    
    func guestLogin(distinctId: String) {
        let param: [String : Any] = [
            "email": "guest_\(distinctId)@factoftheday.in",
            "name": "Guest User \(distinctId)",
            "password": "\(distinctId)",
            "device_token": AppConstants.deviceToken,
            "device_type": AppConstants.deviceType,
            "device_name": AppConstants.deviceName
        ]
        
        print(param)
        LoginManager.share.signUpFromEmail(param: param, callback: { [weak self] response , error in
            
            guard response != nil, error == nil else {
                self?.callGuestLoginIfMailExist(distinctId: distinctId)
                return
            }
            
            FirebaseEvents.signupEvent()
            self?.view?.loginSuccess()
            
        })
    }
    
    private func callGuestLoginIfMailExist(distinctId: String) {
        let param : [String : Any] = [
            "email": "guest_\(distinctId)@factoftheday.in",
            "password": "\(distinctId)",
            "device_token": AppConstants.deviceToken,
            "device_type": AppConstants.deviceType,
            "device_name": AppConstants.deviceName
        ]
        
        LoginManager.share.loginFromEmail(param: param, callback: { [weak self] response , error in
            
            
            guard response != nil, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            FirebaseEvents.loginEvent()
            self?.view?.loginSuccess()
            
        })
    }
}
