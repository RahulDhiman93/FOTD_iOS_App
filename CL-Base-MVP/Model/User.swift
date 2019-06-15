//
//  User.swift
//  CLApp
//
//  Created by Hardeep Singh on 12/3/16.
//  Copyright © 2016 Hardeep Singh. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    var id: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var userName: String
    var addresses: [Any]?
    var cards: [Any]?
    var fullName: String? {
        var components = PersonNameComponents()
        components.givenName = self.firstName
        components.familyName = self.lastName
        let name = PersonNameComponentsFormatter.localizedString(from: components, style: .default, options: [])
        return name.capitalized
    }
    
    required init?(with param: [String: Any]) {
        print(param)
        guard let id = param["_id"] as? String else {
            return nil
        }
        guard let firstName = param["firstName"] as? String else {
            return nil
        }
        guard let lastName = param["lastName"] as? String else {
            return nil
        }
        guard let userName = param["userName"] as? String else {
            return nil
        }
        guard let phoneNumber = param["phoneNumber"] as? String else {
            return nil
        }
        guard let email = param["email"] as? String else {
            return nil
        }
        self.firstName = firstName
        self.lastName  = lastName
        self.id = id
        self.userName = userName
        self.phoneNumber = phoneNumber
        self.email = email
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let id = aDecoder.decodeObject(forKey: "id") as? String else {
            return nil
        }
        guard let firstName = aDecoder.decodeObject(forKey: "firstName") as? String else {
            return nil
        }
        guard let lastName = aDecoder.decodeObject(forKey: "lastName") as? String else {
            return nil
        }
        guard let userName = aDecoder.decodeObject(forKey: "userName") as? String else {
            return nil
        }
        guard let phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String else {
            return nil
        }
        guard let email = aDecoder.decodeObject(forKey: "email") as? String else {
            return nil
        }
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.userName = userName
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(userName, forKey: "userName")
    }
}

extension User: JSONSerializable {
}

extension User: SerializableArray {
}
