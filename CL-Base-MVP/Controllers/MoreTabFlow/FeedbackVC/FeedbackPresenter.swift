//
//  FeedbackPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 13/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation

protocol FeedbackPresenterDelegate : class {
    func failure(message: String)
}

class FeedbackPresenter {
    
    weak var view  : FeedbackPresenterDelegate?
    
    init(view: FeedbackPresenterDelegate) {
        self.view = view
    }
    
    
}
