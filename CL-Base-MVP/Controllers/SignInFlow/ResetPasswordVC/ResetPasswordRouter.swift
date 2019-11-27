//
//  ResetPasswordRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 27/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation
import UIKit

class ResetPasswordRouter: Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func ResetPasswordVC() -> ResetPasswordViewController? {
        let sb = UIStoryboard(name: "SignIn", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "ResetPasswordViewController") as? ResetPasswordViewController else {
            return nil
        }
        return vc
    }
}
