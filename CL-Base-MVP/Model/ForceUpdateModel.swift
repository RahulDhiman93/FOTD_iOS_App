//
//  ForceUpdateModel.swift
//  Inforu
//
//  Created by Rahul Dhiman on 18/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class ForceUpdateModel: NSObject {

    var isForceUpdate : Bool?
    var isManualUpdate : Bool?
    var appLink : String?
    var packageName : String?
    var hardVersion : Int?
    var softVersion : Int?
    
    init?(json : [String : Any]) {
    
        guard let isForceUpdate = json["is_force_update"] as? Bool else {
            return nil
        }
        
        guard let isManualUpdate = json["is_manual_update"] as? Bool else {
            return nil
        }
        
        guard let appLink = json["app_link"] as? String else {
            return nil
        }
        
        guard let packageName = json["package_name"] as? String else {
            return nil
        }
        
        guard let hardVersion = json["hard_version"] as? Int else {
            return nil
        }
        
        guard let softVersion = json["soft_version"] as? Int else {
            return nil
        }
        
        if let aboutUs = json["about_us_page"] as? String  {
            AppConstants.aboutUs = aboutUs
        }
        
        if let instagramPage = json["insta_handle"] as? String  {
            AppConstants.instgramLink = instagramPage
        }
        
        if let showAd = json["ad_mob_enabled"] as? Int {
            SHOW_ADV = showAd == 1
        }
        
        self.isForceUpdate = isForceUpdate
        self.isManualUpdate = isManualUpdate
        self.appLink = appLink
        self.packageName = packageName
        self.hardVersion = hardVersion
        self.softVersion = softVersion
        
    }
    
}
