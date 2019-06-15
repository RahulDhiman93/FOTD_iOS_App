//
//  CustomError.swift
//  SylvanParent
//
//  Created by cl-macmini-79 on 27/11/17.
//  Copyright © 2017 Click-Labs. All rights reserved.
//

import Foundation



enum TextFieldError: Error, Equatable {
    case firstNameEmpty
    case lastNameEmpty
    case emailEmpty
    case phoneNumberEmpty
    case userNameEmpty
    case passwordEmpty
    case confirmPasswordEmpty
    case referEmpty
    case emailInvalid
    case phoneInvalid
    case userNameInvalid
    case passwordInvalid
    case confirmPasswordNotMatched
    
    var localizedDescription: String {
        switch self {
        case .firstNameEmpty:
            return "First name is a required field".localized
        case .lastNameEmpty:
            return "Last name is a required field".localized
        case .emailEmpty:
            return "Email is a required field".localized
        case .phoneNumberEmpty:
            return "Phone number is a required field".localized
        case .userNameEmpty:
            return "Username is a required field".localized
        case .passwordEmpty:
            return "Password is a required field".localized
        case .confirmPasswordEmpty:
            return "Confirm password is a required field".localized
        case .referEmpty:
            return ""
        case .emailInvalid:
            return "Email is not valid".localized
        case .phoneInvalid:
            return "Phone number is not valid".localized
        case .userNameInvalid:
            return "User name is not valid".localized
        case .passwordInvalid:
            return "Password must be valid".localized
        case .confirmPasswordNotMatched:
            return "Password and confirm password does't matched".localized
        }
    }
}

func == (lhs: TextFieldError, rhs: TextFieldError) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
