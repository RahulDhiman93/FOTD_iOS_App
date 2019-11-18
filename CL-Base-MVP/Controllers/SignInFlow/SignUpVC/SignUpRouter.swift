//
//  SignUpRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 17/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation
import UIKit

class SignUpRouter: Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func SignUpVC() -> SignUpViewController? {
        let sb = UIStoryboard(name: "SignIn", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else {
            return nil
        }
        return vc
    }
}
