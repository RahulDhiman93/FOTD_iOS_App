//
//  ProfilePresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import Foundation
import UIKit

protocol ProfilePresenterDelegate : class {
    func failure(message: String)
    func fetchProfileSuccess()
    func updateHippo()
    func emailSuccess()
}

class ProfilePresenter {
    
    weak var view  : ProfilePresenterDelegate?
    
    init(view: ProfilePresenterDelegate) {
        self.view = view
    }
    
    func getProfileData() {
        
        LoginManager.share.loginFromAccessToken(callback: { [weak self] response , error in
            
            guard response != nil, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.view?.fetchProfileSuccess()
            
        })
        
    }
    
    func sendForgotPasswordEmail() {
        
        guard let me = LoginManager.share.me else {
            self.view?.failure(message: "Please type in yout email address")
            return
        }
        
        let email = me.email
        
        UserAPI.share.forgotPassword(email: email, callback: { [weak self] response, error in
            
            guard response != nil, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.view?.emailSuccess()
        })
        
    }
    
    func addProfileImage(profileImage : UIImage) {
        
        LoginManager.share.updateProfilePic(profileImage: profileImage, callback: { [weak self] response, error in
            
            guard response != nil, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.view?.updateHippo()
            self?.getProfileData()
        })
    }
    
    func toggleNotificationSettings(isNotificationEnabled : Int) {
        
        
        UserAPI.share.toggleNotificationSettings(notificationEnabled: isNotificationEnabled, callback: { [weak self] response, error in
            
            
            guard response != nil, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            
        })
        
    }
    
}
