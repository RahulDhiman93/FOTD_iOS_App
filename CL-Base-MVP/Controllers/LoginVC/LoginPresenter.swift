//
//  LoginPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 17/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation

protocol LoginPresenterDelegate : class {
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
            "user_email"    : email,
            "password" : password
        ]
        
        LoginManager.share.loginFromEmail(param: param, callback: { [weak self] response , error in
            
            
            guard response != nil, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            self?.view?.loginSuccess()
            
            
        })
    }
}
