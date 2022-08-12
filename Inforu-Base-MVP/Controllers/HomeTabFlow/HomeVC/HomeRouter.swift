//
//  HomeRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 27/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter: Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func HomeVC() -> HomeViewController? {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            return nil
        }
        return vc
    }
}
