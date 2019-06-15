//
//  SignUpRouter.swift
//  CL-Base-MVP
//
//  Created by shubam garg on 03/04/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import Foundation
import UIKit

protocol SignUpRouter {
    func goToHomeViewController()
}

class SignUpRouterImplementation: Router{
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func signUpVC() -> SignUpViewController? {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else {
            return nil
        }
        return vc
    }
}

extension SignUpRouterImplementation: SignUpRouter {
    func goToHomeViewController() {
        guard let vc = HomeRouter.homeVC() else {
            return
        }
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}

