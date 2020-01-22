//
//  UserAddedFactsRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 22/01/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import Foundation
import UIKit

class UserAddedFactsRouter :  Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func UserAddedFactsVC() -> UserAddedFactsViewController? {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "UserAddedFactsViewController") as? UserAddedFactsViewController else {
            return nil
        }
        return vc
    }
}
