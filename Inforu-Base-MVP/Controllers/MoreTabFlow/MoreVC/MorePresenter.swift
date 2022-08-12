//
//  MorePresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation

enum numberOfMoreVcRows : Int {
    case profile
    case favourites
    case conversations
    case instagram
    case feedback
    case share
    case aboutUs
    case logout
    static let count = logout.rawValue + 1
}

protocol MorePresenterDelegate : AnyObject {
    func failure(message: String)
    func logoutSuccess()
}

class MorePresenter {
    
    weak var view  : MorePresenterDelegate?
    
    init(view: MorePresenterDelegate) {
        self.view = view
    }
    
    func numberOfRows() -> Int {
        return numberOfMoreVcRows.count
    }
    
    func logoutCall() {
        
        LoginManager.share.logout(callback: { [weak self] response, error in
            
            guard response != nil, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.view?.logoutSuccess()
        })
        
    }
}
