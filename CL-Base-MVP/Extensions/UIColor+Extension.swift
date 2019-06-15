//
//  UIColor+Extension.swift
//  CLApp
//
//  Created by cl-macmini-68 on 09/12/16.
//  Copyright © 2016 Hardeep Singh. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(netHex: Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    @nonobjc class var sciYellow: UIColor {
        return UIColor(red: 254.0 / 255.0, green: 207.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var sciLightOrange: UIColor {
        return UIColor(red: 253.0 / 255.0, green: 189.0 / 255.0, blue: 57.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var sciPeach: UIColor {
        return UIColor(red: 238.0 / 255.0, green: 103.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var errorColor: UIColor {
        return UIColor(red: 104 / 255.0, green: 11 / 255.0, blue: 38 / 255.0, alpha: 1.0)
    }
    @nonobjc class var normalLineColor: UIColor {
        return UIColor(red: 155 / 255.0, green: 155 / 255.0, blue: 155 / 255.0, alpha: 1.0)
    }
    @nonobjc class var highlightLineColor: UIColor {
        return UIColor(red: 123 / 255.0, green: 192 / 255.0, blue: 68 / 255.0, alpha: 1.0)
    }
    @nonobjc class var placeHolderColor: UIColor {
        return UIColor(red: 52 / 255.0, green: 73 / 255.0, blue: 94 / 255.0, alpha: 1.0)
    }
    @nonobjc class var spBtnPinkColor: UIColor {
        return UIColor(red: 225 / 255.0, green: 19 / 255.0, blue: 94 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var spLightBlue: UIColor {
        return UIColor(red: 35 / 255.0, green: 47 / 255.0, blue: 132 / 255.0, alpha: 0.4)
    }
    
}

