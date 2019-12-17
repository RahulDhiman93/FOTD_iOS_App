//
//  PopularRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 16/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation
import UIKit

class PopularRouter: Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func PopularVC() -> PopularViewController? {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "PopularViewController") as? PopularViewController else {
            return nil
        }
        return vc
    }
}
