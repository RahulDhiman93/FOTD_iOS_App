//
//  FactDetailModel.swift
//  Inforu
//
//  Created by Rahul Dhiman on 11/12/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit

class FactDetailModel: NSObject {

    var addedByUserId : Int?
    var addedBy   : String?
    var addedOn   : String?
    var fact      : String?
    var factId    : Int?
    var userImage : String?
    var userLikeStatus : Int?
    var likeCount : Int?
    var userFavStatus : Int?
    var dislikeCount : Int?
    
    init?(json : [String : Any]) {
        
        guard let addedBy = json["added_by"] as? String else {
            return nil
        }
        
        guard let addedOn = json["added_on"] as? String else {
            return nil
        }
        
        guard let fact = json["fact"] as? String else {
            return nil
        }
        
        guard let factId = json["fact_id"] as? Int else {
            return nil
        }
        
        guard let userImage = json["user_image"] as? String else {
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
        
        if let addedByUserId = json["user_id"] as? Int {
            self.addedByUserId = addedByUserId
        }
        
        
        self.addedBy   = addedBy.contains("Guest User") ? "Guest User" : addedBy
        self.addedOn   = addedOn
        self.fact      = fact
        self.factId    = factId
        self.userImage = userImage
        self.userFavStatus = userFavStatus
        self.likeCount = likeCount
        self.userLikeStatus = userLikeStatus
        self.dislikeCount = dislikeCount
    }
    
}
