//
//  RandomFactModel.swift
//  FOTD
//
//  Created by Rahul Dhiman on 31/01/19.
//  Copyright © 2019 Rahul Dhiman. All rights reserved.
//

import UIKit

class RandomFactModel: NSObject , NSCoding {

    var factId = 0
    var factText = ""
    var splashKey = ""
    
    init(json: [String:Any]){
        
        if let value = json["fact_id"] as? Int {
            self.factId = value
        }
        
        if let value = json["fact"] as? String {
            self.factText = value
        }
        
        if let value = json["fact_key"] as? String {
            self.splashKey = value
        }
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        
        let factId = aDecoder.decodeInteger(forKey: "factId")
        let factText = aDecoder.decodeObject(forKey: "factText") as! String
        let splashKey = aDecoder.decodeObject(forKey: "splashKey") as! String
        
        let params : [String : Any] = [
            "fact_id" : factId,
            "fact" : factText,
            "fact_key" : splashKey
        ]
        
        self.init(json: params)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(factId, forKey: "factId")
        aCoder.encode(factText, forKey: "factText")
        aCoder.encode(splashKey, forKey: "splashKey")
    }
    
}
