//
//  Validation.swift
//  SylvanParent
//
//  Created by cl-macmini-79 on 24/11/17.
//  Copyright © 2017 Click-Labs. All rights reserved.
//

import Foundation

func nameValid(string: String) -> Bool {
    guard string.rangeOfCharacter(from: nameValidCharacters.inverted) == nil else {
        return false
    }
    if string.length > nameCharacterLimit {
        return false
    }
    return true
}

func validEmailLength(string: String) -> Bool {
    if string.length > emailCharaterLimit {
        return false
    }
    return true
}

func phoneNumberLenth(string: String) -> Bool {
    guard string.rangeOfCharacter(from: phoneValidCharacters.inverted) == nil else {
        return false
    }
    if string.length > phoneNumberLimit {
        return false
    }
    return true
}

func userNameValidLength(string: String) -> Bool {
    guard string.rangeOfCharacter(from: userNameValidCharacters.inverted) == nil else {
        return false
    }
    if string.length > userNameMaxLimit {
        return false
    }
    return true
}

func passwordValidLength(string: String) -> Bool {
    if string.length > passwordMaxLimit || string.containsWhiteSpace() {
        return false
    }
    return true
}

func userNameValidations(string: String) -> TextFieldError? {
    if string.length > userNameMaxLimit || string.length < userNameMinimumLenght {
        return .userNameInvalid
    }
    return nil
}

func phoneNumberValidation(string: String) -> TextFieldError? {
    if string.length < phoneNumberLimit {
        return .phoneInvalid
    }
    return nil
}

func emailValidation(string: String) -> TextFieldError? {
    if !isValidEmail(testStr: string) {
        return .emailInvalid
    }
    return nil
}

func passwordValidation(string: String) -> TextFieldError? {
    let password = "(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,50}"
    let passwordTest = NSPredicate(format:"SELF MATCHES %@", password)
    if !passwordTest.evaluate(with: string) {
        return .passwordInvalid
    }
    return nil
}

func isValidEmail(testStr: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

