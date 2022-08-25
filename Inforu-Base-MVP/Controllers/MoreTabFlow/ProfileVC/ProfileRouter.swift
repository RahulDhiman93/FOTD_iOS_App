//
//  ProfileRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import Foundation
import UIKit

class ProfileRouter :  Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func ProfileVC() -> ProfileViewController? {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {
            return nil
        }
        return vc
    }
}
