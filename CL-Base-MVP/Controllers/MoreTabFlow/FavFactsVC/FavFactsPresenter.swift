//
//  FavFactsPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation

protocol FavFactsPresenterDelegate : class {
    func failure(message: String)
    func fetchFavFactsSuccess()
}

class FavFactsPresenter {
    
    var favFacts = [SearchFactModel]()
    var limit = 20
    var skip = 0
    
    weak var view  : FavFactsPresenterDelegate?
    
    init(view: FavFactsPresenterDelegate) {
        self.view = view
    }
    
    func getFavFacts() {
        
        UserAPI.share.getFavFact(limit: self.limit, skip: self.skip, callback: { [weak self] response, error in
            
            guard let response = response, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            guard let facts = response["facts"] as? [[String : Any]] else {
                self?.view?.failure(message: "Server Error, Please try again!")
                return
            }
            
    
            self?.favFacts.removeAll()
            for fact in facts {
                if let searchFactObject = SearchFactModel(json: fact) {
                    self?.favFacts.append(searchFactObject)
                }
            }
            
            self?.view?.fetchFavFactsSuccess()
            
        })
        
    }
    
    func removeFactFav(factId : Int) {
        
        UserAPI.share.addFactFav(factId: factId, status: 0, callback: { [weak self] response , error in
           
            guard response != nil, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.view?.fetchFavFactsSuccess()
        })
        
    }
    
}
