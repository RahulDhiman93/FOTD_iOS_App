//
//  SignUpViewPresenter.swift
//  CL-Base-MVP
//
//  Created by Deepak on 29/11/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import Foundation
import UIKit

protocol SignUpPresenter: PresenterDataSource, PresenterTableDataSource {
    func shouldChange(text: String, string: String, index: IndexPath) -> Bool
    func infoTapped(at index: IndexPath)
    func signupTapped()
}


class SignUpViewPresenterImplementation {
    
    enum SignupSectionType: Hashable {
        case firstName
        case lastName
        case email
        case phoneNumber
        case username
        case password
        case confirmPassword
        case submitButton
        var identifier: String {
            switch self {
            case .firstName, .lastName, .email, .phoneNumber, .username,
                 .confirmPassword, .password:
                return InputTextFieldCell.cellIdentifier()
            case .submitButton:
                return SignupButtonCell.cellIdentifier()
            }
        }
    }
    
    private var signupSections: [SignupSectionType] = [.firstName, .lastName, .email, .phoneNumber, .username, .password, .confirmPassword,.submitButton]
    private var signupModels = [SignupSectionType: CellDataModelProtocol]()
    weak private var view: SignupView?
    private var router: SignUpRouter
    
    
    
    init(view: SignupView, router: SignUpRouter) {
        self.view = view
        self.router = router
        setupSignupModel()
    }
    
    // MARK: - TableSetup
    
  
    
    private func setupSignupModel() {
        for section in signupSections {
            signupModels[section] = signUpViewModel(for: section)
        }
    }
    
    private func signUpViewModel(for section: SignupSectionType) -> CellDataModelProtocol {
        switch section {
        case .firstName:
            return DataTextModel(identifier: section.identifier, title: "First Name*".localized, data: "")
        case .lastName:
            return DataTextModel(identifier: section.identifier, title: "Last Name*".localized, data: "")
        case .email:
            var viewModel = DataTextModel(identifier: section.identifier, title: "Email Address*".localized, data: "")
            viewModel.keyBoardType = .emailAddress
            return viewModel
        case .phoneNumber:
            var viewModel = DataTextModel(identifier: section.identifier, title: "Phone Number*".localized, data: "")
            viewModel.keyBoardType = .phonePad
            return viewModel
        case .username:
            var viewModel = DataTextModel(identifier: section.identifier, title: "User Name*".localized, data: "")
            viewModel.showInfoBtn = true
            return viewModel
        case .password:
            var viewModel = DataTextModel(identifier: section.identifier, title: "Password*".localized, data: "")
            viewModel.showInfoBtn = true
            viewModel.secureEntry = true
            return viewModel
        case .confirmPassword:
            var viewModel = DataTextModel(identifier: section.identifier, title: "Confirm Password*".localized, data: "")
            viewModel.showInfoBtn = true
            viewModel.secureEntry = true
            
            return viewModel
        case .submitButton:
            return SignupButtonCellModel(identifier: section.identifier, title: "Create My Free Account".localized)
        }
    }
    
    
    
    func isAllDataValid() -> TextFieldError? {
        for section in signupSections {
            guard var viewModel = signupModels[section] as? DataTextModel, let data = viewModel.data else {
                continue
            }
            if data.trimmingCharacters(in: .whitespaces).isEmpty {
                let error = errorEmpty(for: section)
                addError(for: section, error: error)
                print(error?.localizedDescription as Any)
                
                //self.view?.showError(message: "")
                return error!
            } else if let error = validationError(for: section, string: data) {
                addError(for: section, error: error)
                return error
            } else {
                viewModel.showError = false
                viewModel.highLighterColor = .normalLineColor
                signupModels[section] = viewModel
            }
        }
        return nil
    }
    
    private func getAllData() {
        var param = Modelable()
        for section in signupSections {
            guard let viewModel = signupModels[section] as? DataTextModel, let data = viewModel.data else {
                continue
            }
            switch section {
            case .firstName:
                param["firstName"] = data
            case .lastName:
                param["lastName"] = data
            case .username:
                param["userName"] = data
            case .phoneNumber:
                param["phoneNumber"] = data
            case .password:
                param["password"] = data
            case .email:
                param["email"] = data
            default:
                break
            }
        }
        print(param)
        self.signupAPICalled(with: param)
    }
    
    func replace(string: String, section: SignupSectionType) {
        guard var viewModel = signupModels[section] as? DataTextModel else {
            return
        }
        viewModel.data = string
        signupModels[section] = viewModel
        print(section)
    }
    
    // MARK: - API Calls
    
    private func signupAPICalled(with param: Modelable) {
        
        print("All field are validated.")
        self.router.goToHomeViewController()
    }
    
    private func handleSuccess(response: Modelable) {
        navigateToSuccessView()
    }
    
    private func handleError(error: Error) {
        switch (error as NSError).code {
        case 601:
            self.view?.showForgotPasswordMessage(message: error.localizedDescription)
        default:
            self.view?.showError(message: error.localizedDescription)
        }
    }
    
    // MARK: - Navigation
    
    private func navigateToSuccessView() {
        guard let vc = view as? UIViewController else {
            return
        }
        guard let successView = vc.storyboard?.instantiateViewController(withIdentifier: "SuccessfullyLoggedInVC") else {
            return
        }
        vc.navigationController?.pushViewController(successView, animated: true)
    }
    
    private func navigateToSignIn() {
        guard let presentViewController = view as? UIViewController, let navigationController = presentViewController.navigationController else {
            return
        }
        // If Signin is alerady stacked
        for stackedVC in navigationController.viewControllers {
            if stackedVC is LoginViewController {
                navigationController.popToViewController(stackedVC, animated: true)
                return
            }
        }
        
        // If signin is not stacked
        guard let loginView = presentViewController.storyboard?.instantiateViewController(withIdentifier: "SignInVC") else {
            return
        }
        navigationController.pushViewController(loginView, animated: true)
    }
    
    // MARK: - Validations
    
    private func confirmPasswordValidation(confirmPassword: String) -> TextFieldError? {
        guard let password = (signupModels[.password] as? DataTextModel)?.data else {
            return .passwordEmpty
        }
        if confirmPassword != password {
            return .confirmPasswordNotMatched
        }
        return nil
    }
    
    private func errorEmpty(for type: SignupSectionType) -> TextFieldError? {
        switch type {
        case .firstName:
            return .firstNameEmpty
        case .lastName:
            return .lastNameEmpty
        case .username:
            return .userNameEmpty
        case .phoneNumber:
            return .phoneNumberEmpty
        case .password:
            return .passwordEmpty
        case .confirmPassword:
            return .confirmPasswordEmpty
        case .email:
            return .emailEmpty
        default:
            return nil
        }
    }
    
    private func validationError(for type: SignupSectionType, string: String) -> TextFieldError? {
        switch type {
        case .username:
            return userNameValidations(string: string)
        case .phoneNumber:
            return phoneNumberValidation(string: string)
        case .password:
            return passwordValidation(string: string)
        case .confirmPassword:
            return confirmPasswordValidation(confirmPassword: string)
        case .email:
            return emailValidation(string: string)
        default:
            return nil
        }
    }
    
    
    private func addError(for section: SignupSectionType, error: TextFieldError?) {
        guard var viewModel = signupModels[section] as? DataTextModel else {
            return
        }
        viewModel.error = error
        viewModel.showError = true
        viewModel.highLighterColor = .errorColor
        signupModels[section] = viewModel
    }
}

extension SignUpViewPresenterImplementation: SignUpPresenter {
    var numberOfSection: Int {
        return signupSections.count
    }
    func viewModel(indexPath: IndexPath) -> CellDataModelProtocol {
        let section = signupSections[indexPath.row]
        return signupModels[section]!
    }
    // MARK: - signup button tapped
    func signupTapped() {
        if let error = self.isAllDataValid() {
            print(error.localizedDescription)
            self.view?.showError(message: error.localizedDescription)
        } else {
            self.getAllData()
        }
        //self.view?.reloadTableView()
    }
    func shouldChange(text: String, string: String, index: IndexPath) -> Bool {
        let stringWithoutWhiteSpace = text.trimmingCharacters(in: .whitespaces)
        if stringWithoutWhiteSpace.isEmpty && !string.isBlank {
            return false
        }
        
        let section = signupSections[index.row]
        switch section {
        case .firstName, .lastName:
            if !nameValid(string: text) {
                return false
            }
        case .email:
            if !validEmailLength(string: text) {
                return false
            }
        case .phoneNumber:
            if !phoneNumberLenth(string: text) {
                return false
            }
        case .username:
            if !userNameValidLength(string: text) {
                return false
            }
        case .password:
            if !passwordValidLength(string: text) {
                return false
            }
        default:
            break
        }
        replace(string: text, section: section)
        return true
    }
    
    func infoTapped(at index: IndexPath) {
        let section = signupSections[index.row]
        guard var viewModel = signupModels[section] as? DataTextModel else {
            return
        }
        switch section {
        case .password, .confirmPassword:
            viewModel.secureEntry = !viewModel.secureEntry
            signupModels[section] = viewModel
        default:
            break
        }
        self.view?.reload(at: [index])
    }
}
