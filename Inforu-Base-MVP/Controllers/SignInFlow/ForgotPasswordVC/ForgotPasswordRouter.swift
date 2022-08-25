//
//  ForgotPasswordRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 19/11/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordRouter: Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func ForgotPasswordVC() -> ForgotPasswordViewController? {
        let sb = UIStoryboard(name: "SignIn", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController else {
            return nil
        }
        return vc
    }
}
