//
//  ResetPasswordPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 27/11/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import Foundation

protocol ResetPasswordPresenterDelegate : class {
    func failure(message: String)
    func resetPasswordSuccess()
}

class ResetPasswordPresenter {
    
    weak var view  : ResetPasswordPresenterDelegate?
    
    var accessToken : String?
    var password : String?
    
    init(view: ResetPasswordPresenterDelegate) {
        self.view = view
    }
    
    func resetPassword() {
        
        guard let accessToken = self.accessToken else {
            self.view?.failure(message: "something went wrong")
            return
        }
        
        guard let password = self.password else {
            self.view?.failure(message: "please check your new password and try again!")
            return
        }
        
        guard !password.isEmptyOrWhitespace() else {
            self.view?.failure(message: "please check your new password and try again!")
            return
        }
        
        UserAPI.share.resetPassword(accessToken: accessToken, password: password, callback: { [weak self] response , error in
            
            guard response != nil, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.view?.resetPasswordSuccess()
            
        })
    }
}
