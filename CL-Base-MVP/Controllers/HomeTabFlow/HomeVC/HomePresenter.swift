//
//  HomePresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 27/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation

protocol HomePresenterDelegate : class {
    func failure(message: String)
}

class HomePresenter {
    
    weak var view  : HomePresenterDelegate?
    
    init(view: HomePresenterDelegate) {
        self.view = view
    }
    
}
