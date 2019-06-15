//
//  Me.swift
//  CLApp
//
//  Created by Hardeep Singh on 12/3/16.
//  Copyright © 2016 Hardeep Singh. All rights reserved.
//

import UIKit

typealias Authorization = [String: String]
enum ProfileStatus: String {
    case pending = "PENDING"
    case verified = "VERIFIED"
}

class Me: User {
    var accessToken: String
    var profileStatus: ProfileStatus?
    var isPhoneVerified: Bool?
    var isEmailVerified: Bool?
    var requestHeaders: Authorization {
        return ["authorization": accessToken, "content-language": appDelegate.currentlanguage]
    }
    
    required init?(with param: [String: Any]) {
        print("Singup param \(param)")
        guard let accessToken = param["accessToken"] as? String else {
            return nil
        }
        self.accessToken = accessToken
        self.isEmailVerified = param["isEmailVerified"] as? Bool
        self.isPhoneVerified = param["isPhoneVerified"] as? Bool
        super.init(with: param)
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String else {
            return nil
        }
        self.accessToken = accessToken
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(accessToken, forKey: "accessToken")
        super.encode(with: aCoder)
    }
    
    fileprivate func update(me: Me) {
        self.profileStatus = me.profileStatus
        self.id = me.id
        self.firstName = me.firstName
        self.lastName = me.lastName
        self.phoneNumber = me.phoneNumber
        self.email = me.email
        self.userName = me.userName
    }
    
    fileprivate func updateUser(me: User) {
        self.id = me.id
        self.firstName = me.firstName
        self.lastName = me.lastName
        self.phoneNumber = me.phoneNumber
        self.email = me.email
        self.userName = me.userName
    }
}

