//
//  FactDetailRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 11/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation
import UIKit

class FactDetailRouter :  Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func FactDetailVC() -> FactDetailViewController? {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "FactDetailViewController") as? FactDetailViewController else {
            return nil
        }
        return vc
    }
}
