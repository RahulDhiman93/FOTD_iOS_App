//
//  User.swift
//  CLApp
//
//  Created by Hardeep Singh on 12/3/16.
//  Copyright © 2016 Hardeep Singh. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    
    var userId : Int
    var email: String
    var userName: String
   
    required init?(with param: [String: Any]) {
        print(param)
       
        guard let userId = param["user_id"] as? Int else {
            return nil
        }
        guard let userName = param["name"] as? String else {
            return nil
        }
        guard let email = param["email"] as? String else {
            return nil
        }
    
        self.userId = userId
        self.userName = userName
        self.email = email
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        guard let userId = aDecoder.decodeInteger(forKey: "user_id") as? Int else {
            print("USERID DECODE FAIL")
            return nil
        }

        guard let userName = aDecoder.decodeObject(forKey: "name") as? String else {
            print("USERNAME DECODE FAIL")
            return nil
        }
        guard let email = aDecoder.decodeObject(forKey: "email") as? String else {
            print("EMAIL DECODE FAIL")
            return nil
        }
    
        self.userId = userId
        self.email = email
        self.userName = userName
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userId, forKey: "user_id")
        aCoder.encode(userName, forKey: "name")
        aCoder.encode(email, forKey: "email")
    }
}

extension User: JSONSerializable {
}

extension User: SerializableArray {
}
