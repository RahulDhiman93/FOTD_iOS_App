//
//  FavFactsRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation
import UIKit

class FavFactsRouter :  Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func FavFactsVC() -> FavFactsViewController? {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "FavFactsViewController") as? FavFactsViewController else {
            return nil
        }
        return vc
    }
}
