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
  static let themePrimaryColor = UIColor(red: 41.0/255.0, green: 186.0/255.0, blue: 210.0/255.0, alpha: 1.0)
  static let themeSecondaryColor = UIColor(red: 168.0/255.0, green: 211.0/255.0, blue: 121.0/255.0, alpha: 1.0)
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
