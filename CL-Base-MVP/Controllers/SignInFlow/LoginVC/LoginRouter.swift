//
//  LoginRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 17/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation
import UIKit

class LoginRouter: Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func LoginVC() -> LoginViewController? {
        let sb = UIStoryboard(name: "SignIn", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return nil
        }
        return vc
    }
}
