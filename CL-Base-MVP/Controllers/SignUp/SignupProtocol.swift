//
//  SignupProtocol.swift
//  SylvanParent
//
//  Created by cl-macmini-79 on 21/11/17.
//  Copyright © 2017 Click-Labs. All rights reserved.
//

import Foundation

protocol SignupView: class {
    func reloadTableView()
    func reload(at index: [IndexPath])
    func showError(message: String)
    func showForgotPasswordMessage(message: String) 
}
