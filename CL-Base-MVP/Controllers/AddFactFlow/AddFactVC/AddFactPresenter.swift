//
//  AddFactPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 27/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation

protocol AddFactPresenterDelegate : class {
    func failure(message: String)
    func addSuccess()
}

class AddFactPresenter {
    
    var factText : String?
    
    weak var view  : AddFactPresenterDelegate?
    init(view: AddFactPresenterDelegate) {
        self.view = view
    }
    
    
    func addFact() {
        
        guard let fact = self.factText, !fact.isEmptyOrWhitespace(), fact != "enter fact here!" else {
            self.view?.failure(message: "please write a fact first")
            return
        }
        
        UserAPI.share.addFact(fact: fact, callback: { [weak self] response , error in
            
            guard response != nil , error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.view?.addSuccess()
        })
        
    }
    
}
