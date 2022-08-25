//
//  FeedbackRouter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 13/12/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import Foundation
import UIKit

class FeedbackRouter :  Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func FeedbackVC() -> FeedbackViewController? {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "FeedbackViewController") as? FeedbackViewController else {
            return nil
        }
        return vc
    }
}
