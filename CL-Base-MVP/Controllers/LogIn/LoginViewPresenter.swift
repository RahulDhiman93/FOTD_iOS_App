//
//  LoginViewPresenter.swift
//  CL-Base-MVP
//
//  Created by Deepak on 30/11/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewPresenter: PresenterDataSource, PresenterTableDataSource {
    func shouldChange(text: String, string: String, index: IndexPath) -> Bool
    func signupTapped()
}


class LoginViewPresenterImplementation {
    
    enum LoginSectionType: Hashable {
        case email
        case password
        case submitButton
        var identifier: String {
            switch self {
            case .email,.password:
                return InputTextFieldCell.cellIdentifier()
            case .submitButton:
                return SignupButtonCell.cellIdentifier()
            }
        }
    }
    
    private var loginSections: [LoginSectionType] = [.email, .password, .submitButton]
    private var loginModels = [LoginSectionType: CellDataModelProtocol]()
    weak private var view: SignupView?
    private var router: LoginViewRouter
    
    
    
    
    init(view: SignupView, router: LoginViewRouter) {
        self.view = view
        self.router = router
        self.setupLoginModel()
    }
    
    
    
    private func setupLoginModel() {
        for section in loginSections {
            loginModels[section] = self.loginViewModel(for: section)
        }
    }
    
    private func loginViewModel(for section: LoginSectionType) -> CellDataModelProtocol {
        switch section {
        case .email:
            var viewModel = DataTextModel(identifier: section.identifier, title: "Email Address*".localized, data: "")
            viewModel.keyBoardType = .emailAddress
            return viewModel
        case .password:
            var viewModel = DataTextModel(identifier: section.identifier, title: "Password*".localized, data: "")
            viewModel.showInfoBtn = true
            viewModel.secureEntry = true
            return viewModel
        case .submitButton:
            return SignupButtonCellModel(identifier: section.identifier, title: "Login")
        }
    }
    
   
    
    func replace(string: String, section: LoginSectionType) {
        guard var viewModel = loginModels[section] as? DataTextModel else {
            return
        }
        viewModel.data = string
        loginModels[section] = viewModel
        print(section)
    }
    
   
    
    func isAllDataValid() -> TextFieldError? {
        for section in loginSections {
            guard var viewModel = loginModels[section] as? DataTextModel, let data = viewModel.data else {
                continue
            }
            if data.trimmingCharacters(in: .whitespaces).isEmpty {
                let error = self.errorEmpty(for: section)
                self.addError(for: section, error: error)
                return error
            } else if let error = self.validationError(for: section, string: data) {
                self.addError(for: section, error: error)
                return error
            } else {
                viewModel.showError = false
                viewModel.highLighterColor = .normalLineColor
                loginModels[section] = viewModel
            }
        }
        return nil
    }
    
    private func getAllData() {
        var param = Modelable()
        for section in loginSections {
            guard let viewModel = loginModels[section] as? DataTextModel, let data = viewModel.data else {
                continue
            }
            switch section {
            case .password:
                param["password"] = data
            case .email:
                param["email"] = data
            default:
                break
            }
        }
        print(param)
        self.loginApiCall(with: param)
    }
    
    // MARK: - API Calls
    
    private func loginApiCall(with param: Modelable) {
        print("All field are validated.")
        self.router.goToHomeVc()
    }
    
    // MARK: - Validations
    
    private func confirmPasswordValidation(confirmPassword: String) -> TextFieldError? {
        guard let password = (loginModels[.password] as? DataTextModel)?.data else {
            return .passwordEmpty
        }
        if confirmPassword != password {
            return .confirmPasswordNotMatched
        }
        return nil
    }
    
    private func errorEmpty(for type: LoginSectionType) -> TextFieldError? {
        switch type {
        case .password:
            return .passwordEmpty
        case .email:
            return .emailEmpty
        default:
            return nil
        }
    }
    
    private func validationError(for type: LoginSectionType, string: String) -> TextFieldError? {
        switch type {
        case .password:
            return passwordValidation(string: string)
        case .email:
            return emailValidation(string: string)
        default:
            return nil
        }
    }
    
    private func addError(for section: LoginSectionType, error: TextFieldError?) {
        guard var viewModel = loginModels[section] as? DataTextModel else {
            return
        }
        viewModel.error = error
        viewModel.showError = true
        viewModel.highLighterColor = .errorColor
        loginModels[section] = viewModel
    }
    
}

extension LoginViewPresenterImplementation: LoginViewPresenter {
    
    var numberOfSection: Int {
        return loginSections.count
    }
    
    func shouldChange(text: String, string: String, index: IndexPath) -> Bool {
        let stringWithoutWhiteSpace = text.trimmingCharacters(in: .whitespaces)
        if stringWithoutWhiteSpace.isEmpty && !string.isBlank {
            return false
        }
        
        let section = loginSections[index.row]
        switch section {
            
        case .email:
            if !validEmailLength(string: text) {
                return false
            }
            
        case .password:
            if !passwordValidLength(string: text) {
                return false
            }
        default:
            break
        }
        self.replace(string: text, section: section)
        return true
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
    
    // MARK: - TableSetup
    
    func viewModel(indexPath: IndexPath) -> CellDataModelProtocol {
        let section = loginSections[indexPath.row]
        return loginModels[section]!
    }
}
