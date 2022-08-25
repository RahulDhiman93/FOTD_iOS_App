//
//  SearchFactPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import Foundation

protocol SearchFactPresenterDelegate : class {
    func failure(message: String)
    func searchSuccess()
}

class SearchFactPresenter {
    
    
    var searchFacts = [SearchFactModel]()
    var limit = 5
    var skip = 0
    
    weak var view  : SearchFactPresenterDelegate?
    
    init(view: SearchFactPresenterDelegate) {
        self.view = view
    }
    
    func searchFact(searchText : String) {
         
        UserAPI.share.searchFact(searchString: searchText, factType: 2, limit: self.limit, skip: self.skip, callback: { [weak self] response , error  in
            
            guard let response = response, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            guard let facts = response["facts"] as? [[String : Any]] else {
                self?.view?.failure(message: "Server Error, Please try again!")
                return
            }
            
            if self?.skip == 0 {
                self?.searchFacts.removeAll()
            }
            for fact in facts {
                if let searchFactObject = SearchFactModel(json: fact) {
                    self?.searchFacts.append(searchFactObject)
                }
            }
            
            FirebaseEvents.searchEvent(searchTerm: searchText)
            self?.view?.searchSuccess()
        })
        
    
    }
    
    
}
