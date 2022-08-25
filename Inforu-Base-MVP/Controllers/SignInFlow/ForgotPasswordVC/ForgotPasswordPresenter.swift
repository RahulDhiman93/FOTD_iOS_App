//
//  ForgotPasswordPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 19/11/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import Foundation


protocol ForgotPasswordPresenterDelegate : class {
    func failure(message: String)
    func emailSuccess()
}

class ForgotPasswordPresenter {
    
    weak var view  : ForgotPasswordPresenterDelegate?
    
    var email : String?
    
    init(view: ForgotPasswordPresenterDelegate) {
        self.view = view
    }
    
    func sendForgotPasswordEmail() {
        
        guard let email = self.email else {
            self.view?.failure(message: "Please type in your email address")
            return
        }
        
        UserAPI.share.forgotPassword(email: email, callback: { [weak self] response, error in
            
            guard response != nil, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.view?.emailSuccess()
        })
        
    }
    
}
