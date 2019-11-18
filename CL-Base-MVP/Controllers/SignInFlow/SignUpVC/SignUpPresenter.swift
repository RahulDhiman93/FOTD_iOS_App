//
//  SignUpPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 17/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation

protocol SignUpPresenterDelegate : class {
    func failure(message: String)
    func SignUpSuccess()
}

class SignUpPresenter {
    
    weak var view  : SignUpPresenterDelegate?
    var username : String?
    var email    : String?
    var password : String?
    
    init(view: SignUpPresenterDelegate) {
        self.view = view
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func signUpFromEmail() {
        guard let username = self.username else {
            self.view?.failure(message: "Please enter your username")
            return
        }
        
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
        
        let param: [String : Any] = [
            "email": email,
            "name": username,
            "password": password,
            "device_token": AppConstants.deviceToken,
            "device_type": AppConstants.deviceType,
            "device_name": AppConstants.deviceName
        ]
        
        print(param)
        LoginManager.share.signUpFromEmail(param: param, callback: { [weak self] response , error in
            
            guard response != nil, error == nil else {
                self?.view?.failure(message: error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            self?.view?.SignUpSuccess()
            
        })
    }
}
