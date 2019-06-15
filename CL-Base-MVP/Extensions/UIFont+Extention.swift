//
//  UIFont+Extention.swift
//  RentMy
//
//  Created by cl-macmini-79 on 16/05/17.
//  Copyright © 2017 Click-Labs. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func appFontRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "HelveticaNeue-Medium", size: size)
    }
    class func appFontlight(size: CGFloat) -> UIFont? {
        return UIFont(name: "HelveticaNeue-Light", size: size)
    }
    class func appFontbold(size: CGFloat) -> UIFont? {
        return UIFont(name: "HelveticaNeue-Bold", size: size)
    }
}
