//
//  FactModel.swift
//  Inforu
//
//  Created by Rahul Dhiman on 18/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class FactModel: NSObject {

    var fact : Fact?
    var userLikeStatus : Int?
    var likeCount : Int?
    var userFavStatus : Int?
    var dislikeCount : Int?
    
    init?(json : [String : Any]) {
        
        guard let factData = json["fact"] as? [String : Any] else {
            return nil
        }
        
        guard let fact = Fact(json: factData) else {
            return nil
        }
        
        guard let userLikeStatus = json["user_like_status"] as? Int else {
            return nil
        }
        
        guard let likeCount = json["like_count"] as? Int else {
            return nil
        }
        
        guard let userFavStatus = json["user_fav_status"] as? Int else {
            return nil
        }
        
        guard let dislikeCount = json["dislike_count"] as? Int else {
            return nil
        }
        
        self.fact = fact
        self.userFavStatus = userFavStatus
        self.likeCount = likeCount
        self.userLikeStatus = userLikeStatus
        self.dislikeCount = dislikeCount
        
    }
    
    
}

struct Fact {
    
    var factId : Int?
    var fact : String?
    var factStamp : String?
    var factStatus : Int?
    var factTag : String?
    var factType : Int?
    var minimumDislikeCount : Int?
    var minimumLikeCount : Int?
    var updateDateTime : String?
    var creationDateTime : String?
    
    init?(json : [String : Any]) {
        
        guard let factId = json["fact_id"] as? Int else {
            return nil
        }
        
        guard let fact = json["fact"] as? String else {
            return nil
        }
        
        guard let factStamp = json["fact_stamp"] as? String else {
            return nil
        }
        
        guard let factStatus = json["fact_status"] as? Int else {
            return nil
        }
        
        guard let factTag = json["fact_tag"] as? String else {
            return nil
        }
        
        guard let factType = json["fact_type"] as? Int else {
            return nil
        }
        
        guard let minimumDislikeCount = json["minimum_dislike_count"] as? Int else {
            return nil
        }
        
        guard let minimumLikeCount = json["minimum_like_count"] as? Int else {
            return nil
        }
        
        guard let updateDateTime = json["update_datetime"] as? String else {
            return nil
        }
        
        guard let creationDateTime = json["creation_datetime"] as? String else {
            return nil
        }
        
        
        self.factId = factId
        self.fact = fact.lowercased()
        self.factStamp = factStamp
        self.factStatus = factStatus
        self.factTag = factTag
        self.factType = factType
        self.minimumDislikeCount = minimumDislikeCount
        self.minimumLikeCount = minimumLikeCount
        self.updateDateTime = updateDateTime
        self.creationDateTime = creationDateTime
        
    }
    
}
