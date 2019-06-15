//
//  LandingRouter.swift
//  CL-Base-MVP
//
//  Created by shubam garg on 03/04/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import Foundation
import UIKit

protocol LandingRouter {
    func goToLogin()
    func goToSignUp()
}

class LandingRouterImplementation: Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
}

extension LandingRouterImplementation: LandingRouter {
    
    func goToLogin() {
        guard let vc = LoginViewRouterImplementation.loginVC() else {
            return
        }
        let loginRouter = LoginViewRouterImplementation(with: vc)
        vc.presenterDelegate = LoginViewPresenterImplementation(view: vc, router: loginRouter)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToSignUp() {
        guard let vc = SignUpRouterImplementation.signUpVC() else {
            return
        }
        let signUpRouter = SignUpRouterImplementation(with: vc)
        vc.presenterDelegate = SignUpViewPresenterImplementation(view: vc, router: signUpRouter)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
