//
//  TodaysFactRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 18/11/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import Foundation
import UIKit

class TodaysFactRouter: Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func TodaysFactVC() -> TodaysFactViewController? {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "TodaysFactViewController") as? TodaysFactViewController else {
            return nil
        }
        return vc
    }
}
