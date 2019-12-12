//
//  CLAppConstants.swift
//  CLApp
//
//  Created by cl-macmini-68 on 09/12/16.
//  Copyright © 2016 Hardeep Singh. All rights reserved.
//

import Foundation
import UIKit

struct AppColor {
  static let AppBackgroundColor = UIColor(red: 255, green: 255, blue: 255)
  static let AppTextColor = UIColor(red: 0, green: 0, blue: 0)
  static let themePrimaryColor = UIColor(red: 60.0/255.0, green: 67.0/255.0, blue: 153.0/255.0, alpha: 1.0)
  static let themeSecondaryColor = UIColor(red: 225.0/255.0, green: 184.0/255.0, blue: 178.0/255.0, alpha: 1.0)
}

let nameCharacterLimit = 64
let emailCharaterLimit = 128
let phoneNumberLimit = 10
let userNameMaxLimit = 20
let userNameMinimumLenght = 6
let passwordMaxLimit = 64
let passwordMinimumLenght = 6
let nameValidCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ")
let phoneValidCharacters = CharacterSet(charactersIn: "0123456789")
let userNameValidCharacters = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ-'")
let deviceType: String = "IOS"
let screen = UIScreen.main.bounds
