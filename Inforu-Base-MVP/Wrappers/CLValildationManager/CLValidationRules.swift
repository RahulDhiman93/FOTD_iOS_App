//
//  CLValidationRules.swift
//  CLApp
//
//  Created by cl-macmini-68 on 30/12/16.
//  Copyright © 2016 Hardeep Singh. All rights reserved.
//

import Foundation

struct CLValidation {
  
  static func blankRulesSet(with message: String) {
    
  }
  
  // MARK: - Blank validation.
  static var blankRulesSet: ValidationRuleSet<String> {
    let ruleRequired =  ValidationRuleBlank(error: ValidationError(message: "All field is mendatory".localized))
    var validateRuelsSet = ValidationRuleSet<String>()
    validateRuelsSet.add(rule: ruleRequired)
    return validateRuelsSet
  }
  
  // MARK: - Email validations.
  static var emailRulesSet: ValidationRuleSet<String> {
    
    //Email cannot blank
    let ruleRequired =  ValidationRuleBlank(error: ValidationError(message: "Email is required".localized))
    //Email format validation
    let validateRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: ValidationError(message: "Email is not valid".localized))
    
    //Set of rules
    var validateRuelsSet = ValidationRuleSet<String>()
    validateRuelsSet.add(rule: ruleRequired)
    validateRuelsSet.add(rule: validateRule)
    return validateRuelsSet
    
  }
  
  // MARK: - Phone number validations.
  static var phoneRulesSet: ValidationRuleSet<String> {
    
    //Email cannot blank
    let ruleRequired =  ValidationRuleBlank(error: ValidationError(message: "Phone number is required".localized))
    //Email format validation
    let digitPattern = ContainsNumberValidationPattern()
    let validateRule = ValidationRulePattern(pattern: digitPattern, error: ValidationError(message: "Phone number is not valid".localized))
    
    //Set of rules
    var validateRuelsSet = ValidationRuleSet<String>()
    validateRuelsSet.add(rule: ruleRequired)
    validateRuelsSet.add(rule: validateRule)
    return validateRuelsSet
    
  }
  
  // MARK: - First Name Validations
  static var firstNameRuleSet: ValidationRuleSet<String> {
    var nameRules = ValidationRuleSet<String>()
    //Name cannot be blank
    let ruleRequired = ValidationRuleBlank(error: ValidationError(message: "First name is required".localized))
    //Name cannot contain digits
    let firstNameValidation = ValidationRulePattern(pattern: ".*?[A-Za-z]", error: ValidationError(message: "Invalid first name".localized))
    
    nameRules.add(rule: ruleRequired)
    nameRules.add(rule: firstNameValidation)
    return nameRules
  }
  
  // MARK: - LastName Validations
  static var lastNameRuleSet: ValidationRuleSet<String> {
    var nameRules = ValidationRuleSet<String>()
    //Name cannot be blank
    let ruleRequired = ValidationRuleBlank(error: ValidationError(message: "Last name is required".localized))
    //Name cannot contain digits
    let firstNameValidation = ValidationRulePattern(pattern: ".*?[A-Za-z]", error: ValidationError(message: "Invalid last name".localized))
    
    nameRules.add(rule: ruleRequired)
    nameRules.add(rule: firstNameValidation)
    return nameRules
  }
  
  // MARK: - Pasword validations.
  static var passwordRulesSet: ValidationRuleSet<String> {
    
    var passRules = ValidationRuleSet<String>()
    
    //Password length
    let  passValidation = ValidationRuleLength(min: 8,
                                               max: 50,
                                               error: ValidationError(message: "Password must be eight characters".localized))
    passRules.add(rule: passValidation)
    
    //Special character required.
    //        let specialSymbol = ValidationRulePattern(pattern: ".*[^A-Za-z0-9].*",
    //                                              error: ValidationError(message: "Password must contain at least one special character".localized))
    //        passRules.add(rule: specialSymbol)
    
    //A digit is required.
    //        let digitRule = ValidationRulePattern(pattern: ".*?[0-9]",
    //                                              error: ValidationError(message: "Password must contain at least one digit character".localized))
    //        passRules.add(rule: digitRule)
    
    //A UpperCase is required.
    //        let oneUpperCase  = ValidationRulePattern(pattern: ".*?[A-Z]",
    //                                              error: ValidationError(message: "Password must contain at least  one upper case character".localized))
    //        passRules.add(rule: oneUpperCase)
    
    //A lowerCase is required.
    //        let onelowerCase  = ValidationRulePattern(pattern: ".*?[a-z]",
    //                                                  error: ValidationError(message: "Password must contain at least  one upper case character".localized))
    //        passRules.add(rule: onelowerCase)
    return passRules
  }
  
}
