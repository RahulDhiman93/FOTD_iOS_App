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
}

class UserAddedFactsPresenter {
    
    var screenType : UserAddedFactsType!
    
    weak var view  : UserAddedFactsPresenterDelegate?
    init(view: UserAddedFactsPresenterDelegate, type : UserAddedFactsType) {
        self.view = view
        self.screenType = type
    }
    
}
