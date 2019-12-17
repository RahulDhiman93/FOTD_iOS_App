//
//  PopularPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 16/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation

protocol PopularPresenterDelegate : class {
    func failure(message: String)
    func fetchPopularSuccess()
}

class PopularPresenter {
    
    var skip = 0
    var limit = 10
    var popularFact  = [SearchFactModel]()
    
    weak var view  : PopularPresenterDelegate?
    init(view: PopularPresenterDelegate) {
        self.view = view
    }
    
    func getPopularFact() {
        
        UserAPI.share.getPopularFact(limit: self.limit, skip: self.skip, callback: { [weak self] response, error in
            
            guard let response = response, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            guard let facts = response["facts"] as? [[String : Any]] else {
                self?.view?.failure(message: "Server Error, Please try again!")
                return
            }
            
            for fact in facts {
                if let factObject = SearchFactModel(json: fact) {
                    self?.popularFact.append(factObject)
                }
            }
            
            self?.view?.fetchPopularSuccess()
            
        })
        
    }
    
}
