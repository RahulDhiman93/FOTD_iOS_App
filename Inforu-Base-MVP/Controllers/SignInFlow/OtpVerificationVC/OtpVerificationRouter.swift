//
//  OtpVerificationRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 27/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation
import UIKit

class OtpVerificationRouter: Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func OtpVerificationVC() -> OtpVerificationViewController? {
        let sb = UIStoryboard(name: "SignIn", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "OtpVerificationViewController") as? OtpVerificationViewController else {
            return nil
        }
        return vc
    }
}
