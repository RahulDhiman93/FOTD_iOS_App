//
//  FeedbackPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 13/12/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import Foundation

protocol FeedbackPresenterDelegate : class {
    func failure(message: String)
    func feedbackSubmitSuccess()
}

class FeedbackPresenter {
    
    weak var view  : FeedbackPresenterDelegate?
    
    init(view: FeedbackPresenterDelegate) {
        self.view = view
    }
    
    func submitFeedback(feedback : String) {
        
        UserAPI.share.submitFeedback(feedback: feedback, callback: { [weak self] response, error in
            
            guard response != nil, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.view?.feedbackSubmitSuccess()
            
        })
        
    }
    
}
