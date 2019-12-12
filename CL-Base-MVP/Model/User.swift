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
    var profileImage : String = ""
    var notificationEnabled : Int = 1
    var approvedCount : Int = 0
    var pendingCount : Int = 0
    var rejectedCount : Int = 0
    var totalCount : Int = 0
   
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
        
        if let profileImage = param["profile_image"] as? String {
            self.profileImage = profileImage
        }
        
        if let isNotificationEnabled = param["notification_enabled"] as? Int {
            self.notificationEnabled = isNotificationEnabled
        }
        
        if let userFactCountJson = param["userFactCount"] as? [String : Any] {
            
            if let approved = userFactCountJson["approved_count"] as? Int {
                self.approvedCount = approved
            }
            
            if let pending = userFactCountJson["pending_count"] as? Int {
                self.pendingCount = pending
            }
            
            if let rejected = userFactCountJson["rejected_count"] as? Int {
                self.rejectedCount = rejected
            }
            
            if let total = userFactCountJson["total_count"] as? Int {
                self.totalCount = total
            }
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
