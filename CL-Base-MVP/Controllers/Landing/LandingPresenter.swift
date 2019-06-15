//
//  LandingPresenter.swift
//  CL-Base-MVP
//
//  Created by shubam garg on 03/04/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import Foundation

protocol LandingPresenter: class {
    func loginPressed()
    func signUpPressed()
}

class LandingPresenterImplementation: LandingPresenter {
    
    private var router: LandingRouter
    
    init(router: LandingRouter) {
        self.router = router
    }
    
    func loginPressed() {
        self.router.goToLogin()
    }
    
    func signUpPressed() {
        self.router.goToSignUp()
    }
    
    
}
