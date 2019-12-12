//
//  ProfilePresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation

protocol ProfilePresenterDelegate : class {
    func failure(message: String)
    func fetchProfileSuccess()
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
    
}
