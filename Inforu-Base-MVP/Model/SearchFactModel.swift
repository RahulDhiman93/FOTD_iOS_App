//
//  SearchFactModel.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit

class SearchFactModel: NSObject {

    var fact : String!
    var factId : Int!
//    var factStatus : Int!
//    var factTag : String!
//    var factType : Int!
//    var favStatus : Int!
//    var likeStatus : Int!
//    var minimumDislikeCount : Int!
//    var minimumLikeCount : Int!
    
    init?(json : [String : Any]) {
      
        guard let fact = json["fact"] as? String else {
            return nil
        }
        
        guard let factId = json["fact_id"] as? Int else {
            return nil
        }
        
//        guard let factStatus = json["fact_status"] as? Int else {
//            return nil
//        }
//
//        guard let factTag = json["fact_tag"] as? String else {
//            return nil
//        }
//
//        guard let factType = json["fact_type"] as? Int else {
//            return nil
//        }
//
//        guard let favStatus = json["fav_status"] as? Int else {
//            return nil
//        }
//
//        guard let likeStatus = json["like_status"] as? Int else {
//            return nil
//        }
//
//        guard let minimumDislikeCount = json["minimum_dislike_count"] as? Int else {
//            return nil
//        }
//
//        guard let minimumLikeCount = json["minimum_like_count"] as? Int else {
//            return nil
//        }
        
        self.fact = fact
        self.factId = factId
//        self.factStatus = factStatus
//        self.factTag = factTag
//        self.factType = factType
//        self.favStatus = favStatus
//        self.likeStatus = likeStatus
//        self.minimumLikeCount = minimumLikeCount
//        self.minimumDislikeCount = minimumDislikeCount
//        
    }
    
}
