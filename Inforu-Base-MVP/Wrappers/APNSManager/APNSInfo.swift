//
//  APNSInfo.swift
//  APNSManager
//
//  Created by cl-macmini-68 on 26/04/17.
//  Copyright © 2017 Hardeep Singh. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct AlertBody: Alert {
  var alertText: String?
  var body: String?
  var title: String?
}

struct APNSInfo: APNSPayload {
  var alert: Alert?
  var sound: String?
  var badge: Int = 0
  var contentAvailable: Bool = false
  var bookingId: String?
    var ref: DatabaseReference!
    var userJson : [String : Any]?
  
  init(userInfo: [AnyHashable : Any]) {
    
    userJson = userInfo as? [String : Any]
    ref = Database.database().reference()
    ref.child("apns_info").setValue(userJson ?? ["None" : "None"])
    
    if let aps = userInfo["aps"] as? [String: Any] {
      sound = aps["sound"] as? String
      
        if let alert = aps["alert"] as? [String:Any], let body = alert["body"] as? String, let title = alert["title"] as? String{
        self.alert = AlertBody(alertText: "", body: body, title: title)
      }
      
      sound = aps["sound"] as? String
      if let badge = aps["badge"] as? Int {
        self.badge = badge
      }

    }
    
    bookingId = userInfo["bookingId"] as? String
    
  }
  
}
