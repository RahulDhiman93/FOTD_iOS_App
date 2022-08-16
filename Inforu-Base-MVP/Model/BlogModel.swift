//
//  BlogModel.swift
//  Inforu
//
//  Created by Rahul Dhiman on 10/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class BlogModel: NSObject {

    var addedBy   : String?
    var addedOn   : String?
    var fact      : String?
    var factId    : Int?
    var userImage : String?
    
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
        
        self.addedBy   = addedBy.contains("Guest User") ? "Guest User" : addedBy
        self.addedOn   = addedOn
        self.fact      = fact
        self.factId    = factId
        self.userImage = userImage
        
    }
    
}
