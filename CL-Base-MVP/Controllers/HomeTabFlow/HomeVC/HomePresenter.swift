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
    func featuredSuccess()
}

class HomePresenter {
    
    var featuredFact = [BlogModel]()
    var popularFact  = [BlogModel]()
    var featureFactWithSearchModel = [SearchFactModel]()
    var popularFactWithSearchModel = [SearchFactModel]()
    
    weak var view  : HomePresenterDelegate?
    
    init(view: HomePresenterDelegate) {
        self.view = view
    }
    
    func getFeaturedFact() {
        
        UserAPI.share.getFeatureFact(callback: { [weak self] response , error in
            
            guard let response = response, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            guard let featured = response["featured"] as? [[String : Any]] else {
                self?.view?.failure(message: "Server Error, Please try again!")
                return
            }
            
            guard let popular = response["popular"] as? [[String : Any]] else {
                self?.view?.failure(message: "Server Error, Please try again!")
                return
            }
            
            self?.featuredFact.removeAll()
            self?.featureFactWithSearchModel.removeAll()
            for featureFact in featured {
                if let fact = BlogModel(json: featureFact), let factForSearchModel = SearchFactModel(json: featureFact) {
                    self?.featuredFact.append(fact)
                    self?.featureFactWithSearchModel.append(factForSearchModel)
                }
            }
            
            self?.popularFact.removeAll()
            self?.popularFactWithSearchModel.removeAll()
            for popularFact in popular {
                if let fact = BlogModel(json: popularFact), let factForSearchModel = SearchFactModel(json: popularFact) {
                    self?.popularFact.append(fact)
                    self?.popularFactWithSearchModel.append(factForSearchModel)
                }
            }
            
            self?.view?.featuredSuccess()
        })
        
    }
}
