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
    var requestHeaders: Authorization {
        return ["authorization": accessToken, "content-language": appDelegate.currentlanguage]
    }
    
    required init?(with param: [String: Any]) {
        print("Singup param \(param)")
        guard let accessToken = param["access_token"] as? String else {
            return nil
        }
        self.accessToken = accessToken
        super.init(with: param)
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let accessToken = aDecoder.decodeObject(forKey: "access_token") as? String else {
            return nil
        }
        self.accessToken = accessToken
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(accessToken, forKey: "access_token")
        super.encode(with: aCoder)
    }
    
    fileprivate func update(me: Me) {
        self.profileStatus = me.profileStatus
        self.email = me.email
        self.userName = me.userName
    }
    
    fileprivate func updateUser(me: User) {
        self.email = me.email
        self.userName = me.userName
    }
}

