//
//  UserAPI.swift
//  Inforu
//
//  Created by Rahul Dhiman on 14/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class UserAPI: NSObject {
    static let share = UserAPI()
}

extension UserAPI {
    
    func getTodaysFact(callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        let param : [String : Any] = [:]
        let path = AppConstants.currentServer + "todaysFact"
        
        HTTPRequest(method: .get, fullURLStr: path, parameters: nil, encoding: .json, files: nil)
            .config(isIndicatorEnable: true, isAlertEnable: false)
            .handler(httpModel: false, delay: 0) { (response) in
                
                print(response as Any)
                //  print(error as Any)
                
                if response.error != nil {
                    callback(nil, response.error)
                    return
                }
                
                guard let value = response.value else {
                    callback(nil, nil)
                    return
                }
                
               if let json = value as? [String : Any] ,
                    let statusCode = json["status"] as? Int {
                    
                    if statusCode == 1 {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    } else {
                        callback(nil,nil)
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
}
