//
//  MoreRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import Foundation
import UIKit

class MoreRouter :  Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func MoreVC() -> MoreViewController? {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "MoreViewController") as? MoreViewController else {
            return nil
        }
        return vc
    }
}
