//
//  Config.swift
//  Inforu
//
//  Created by Rahul Dhiman on 15/06/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class Config: NSObject {
  static let sharedInstance = Config()
}

extension Config {
    
    // for getting base Url from the config file
    func baseURL() -> String {
        guard let baseURLString = Bundle.main.infoDictionary?["kBaseURL"] as? String,
            baseURLString.isBlank == false else {
                fatalError("Base url is not set in xcconfig file.")
        }
        return baseURLString // "http://34.205.54.225:3004"
    }
    
}

