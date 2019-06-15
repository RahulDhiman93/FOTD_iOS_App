//
//  HomeRouter.swift
//  CL-Base-MVP
//
//  Created by shubam garg on 01/04/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter {
    static func homeVC() -> HomeController? {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "HomeController") as? HomeController else {
            return nil
        }
        return vc
    }
}
