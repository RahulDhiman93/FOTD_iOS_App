//
//  OtpVerificationPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 27/11/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import Foundation

protocol OtpVerificationPresenterDelegate : class {
    func failure(message: String)
    func otpSuccess()
}

class OtpVerificationPresenter {
    
    weak var view  : OtpVerificationPresenterDelegate?
    
    var otp : String?
    var email : String?
    var accessToken : String?
    var isComingFromMoreTab = false
    
    init(view: OtpVerificationPresenterDelegate) {
        self.view = view
    }
    
    func verifyOtpWithServer() {
        
        guard let email = self.email else {
            self.view?.failure(message: "something went wrong")
            return
        }
        
        guard let otp = self.otp else {
            self.view?.failure(message: "Please enter or check your OTP")
            return
        }
        
        guard !otp.isEmptyOrWhitespace() && otp.count == 4 else {
            self.view?.failure(message: "Please enter or check your OTP")
            return
        }
        
        UserAPI.share.verifyOtp(email: email, otp: otp, callback: { [weak self] response , error in
            
            guard let response = response, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            guard let accessToken = response["access_token"] as? String else {
                self?.view?.failure(message: "Server Error, Please try again!")
                return
            }
            
            self?.accessToken = accessToken
            self?.view?.otpSuccess()
          
        })
        
    }
}
