//
//  SplashPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 17/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation

protocol SplashPresenterDelegate : class {
    func failure(message: String)
    func accessTokenVerified()
    func goToLogin()
    func checkAppVersionSuccess()
}

class SplashPresenter {
    
    
    weak var view  : SplashPresenterDelegate?
    
    var forceUpdateModel : ForceUpdateModel?
    
    init(view: SplashPresenterDelegate) {
        self.view = view
    }
    
    
    func accessTokenApiHit() {
        
        LoginManager.share.loginFromAccessToken(callback: { [weak self] response , error in
            
            guard response != nil, error == nil else {
                self?.view?.failure(message: error?.localizedDescription ?? "Server Error, Please try again!")
                self?.view?.goToLogin()
                return
            }
            
            self?.view?.accessTokenVerified()
          
        })
    }
    
    func checkAppVersion() {
        
        UserAPI.share.checkAppVersion(callback: { [weak self] response , error in
            
            guard let response = response, error == nil else {
                self?.view?.failure(message: error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.forceUpdateModel = ForceUpdateModel(json: response)
            self?.view?.checkAppVersionSuccess()
        })
        
        
    }
    
}
