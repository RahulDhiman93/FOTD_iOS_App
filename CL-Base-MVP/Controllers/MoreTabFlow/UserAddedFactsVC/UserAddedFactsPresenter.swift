//
//  UserAddedFactsPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 22/01/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import Foundation

enum UserAddedFactsType : Int {
    case approved
    case pending
    case discarded
}

protocol UserAddedFactsPresenterDelegate : class {
    func failure(message: String)
    func getUserAddFactsSuccess()
}

class UserAddedFactsPresenter {
    
    var screenType : UserAddedFactsType!
    var facts = [SearchFactModel]()
    var limit = 10
    var skip = 0
    
    weak var view  : UserAddedFactsPresenterDelegate?
    init(view: UserAddedFactsPresenterDelegate, type : UserAddedFactsType) {
        self.view = view
        self.screenType = type
    }
    
    func getUserFactsForStatus() {
        var factStatus = 0
        switch self.screenType {
        case .approved:
            factStatus = 1
        case .pending:
            factStatus = 0
        case .discarded:
            factStatus = 2
        default:
            break
        }
        
        CLProgressHUD.present(animated: true)
        UserAPI.share.getUserAddedFacts(factStatus: factStatus, limit: self.limit, skip: 0, callback: { [weak self] response, error in
            CLProgressHUD.dismiss(animated: true)
            
            guard let response = response, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            guard let facts = response["facts"] as? [[String : Any]] else {
                self?.view?.failure(message: "Server Error, Please try again!")
                return
            }
            
            self?.facts.removeAll()
            for fact in facts {
                if let searchFactObject = SearchFactModel(json: fact) {
                    self?.facts.append(searchFactObject)
                }
            }
            
            self?.view?.getUserAddFactsSuccess()
        })
        
    }
    
    func getUserFactsForStatusForPagination() {
        var factStatus = 0
        switch self.screenType {
        case .approved:
            factStatus = 1
        case .pending:
            factStatus = 2
        case .discarded:
            factStatus = 3
        default:
            break
        }
        
        CLProgressHUD.present(animated: true)
        UserAPI.share.getUserAddedFacts(factStatus: factStatus, limit: self.limit, skip: self.skip, callback: { [weak self] response, error in
            CLProgressHUD.dismiss(animated: true)
            
            guard let response = response, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            guard let facts = response["facts"] as? [[String : Any]] else {
                self?.view?.failure(message: "Server Error, Please try again!")
                return
            }
            
            for fact in facts {
                if let searchFactObject = SearchFactModel(json: fact) {
                    self?.facts.append(searchFactObject)
                }
            }
            
            self?.view?.getUserAddFactsSuccess()
        })
        
    }
    
}
