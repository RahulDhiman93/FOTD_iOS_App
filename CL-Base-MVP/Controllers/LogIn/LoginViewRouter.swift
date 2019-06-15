//
//  LoginViewRouter.swift
//  CL-Base-MVP
//
//  Created by shubam garg on 01/04/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewRouter {
    func goToHomeVc()
}

class LoginViewRouterImplementation: Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func loginVC() -> LoginViewController? {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return nil
        }
        return vc
    }
}

extension LoginViewRouterImplementation: LoginViewRouter {
    func goToHomeVc() {
        guard let vc = HomeRouter.homeVC() else {
            return
        }
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
