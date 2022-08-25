//
//  UserAPI.swift
//  Inforu
//
//  Created by Rahul Dhiman on 14/11/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit

class UserAPI: NSObject {
    static let share = UserAPI()
}

extension UserAPI {
    
    func checkAppVersion(callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        let path = AppConstants.currentServer + "app/version" + "?device_type=\(AppConstants.deviceType)" + "&app_version=\(AppConstants.appVersion)"
        
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func getTodaysFact(callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        guard let me = LoginManager.share.me else { return }
        
        let path = AppConstants.currentServer + "fact/today" + "?access_token=" + me.accessToken
        
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func forgotPassword(email : String, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        let path = AppConstants.currentServer + "user/forgetPassword"
        let param : [String : Any] = ["email" : email]
        
        HTTPRequest(method: .post, fullURLStr: path, parameters: param, encoding: .json, files: nil)
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    
    func verifyOtp(email : String, otp : String, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        let path = AppConstants.currentServer + "user/verifyOtp"
        let param : [String : Any] = ["email" : email, "otp" : otp]
        
        HTTPRequest(method: .post, fullURLStr: path, parameters: param, encoding: .json, files: nil)
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func resetPassword(accessToken : String, password : String, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        let path = AppConstants.currentServer + "user/editProfile"
        let param : [String : Any] = ["access_token" : accessToken, "password" : password]
        
        HTTPRequest(method: .post, fullURLStr: path, parameters: param, encoding: .json, files: nil)
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func addFact(fact : String, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        guard let me = LoginManager.share.me else { return }
        let accessToken = me.accessToken
        
        let path = AppConstants.currentServer + "fact/add"
        let param : [String : Any] = ["access_token" : accessToken, "fact" : fact]
        
        HTTPRequest(method: .post, fullURLStr: path, parameters: param, encoding: .json, files: nil)
            .config(isIndicatorEnable: false, isAlertEnable: false)
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func getFeatureFact(callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        guard let me = LoginManager.share.me else { return }
        let accessToken = me.accessToken
        
        let path = AppConstants.currentServer + "fact/featured" + "?access_token=\(accessToken)"
        
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any]{
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func getFactDetail(factId : Int, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        guard let me = LoginManager.share.me else { return }
        let accessToken = me.accessToken
        
        let path = AppConstants.currentServer + "fact/getDetails" + "?access_token=\(accessToken)" + "&fact_id=\(factId)"
        
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any]{
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END

    func likeFact(factId : Int, status : Int, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        guard let me = LoginManager.share.me else { return }
        let accessToken = me.accessToken
        
        let path = AppConstants.currentServer + "fact/like"
        let param : [String : Any] = ["access_token" : accessToken, "fact_id" : factId, "status" : status]
        
        HTTPRequest(method: .post, fullURLStr: path, parameters: param, encoding: .json, files: nil)
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func addFactFav(factId : Int, status : Int, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        guard let me = LoginManager.share.me else { return }
        let accessToken = me.accessToken
        
        let path = AppConstants.currentServer + "fact/favourite/add"
        let param : [String : Any] = ["access_token" : accessToken, "fact_id" : factId, "status" : status]
        
        HTTPRequest(method: .post, fullURLStr: path, parameters: param, encoding: .json, files: nil)
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func searchFact(searchString : String, factType : Int,limit : Int, skip : Int, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        guard let me = LoginManager.share.me else { return }
        let accessToken = me.accessToken
        
        let path = AppConstants.currentServer + "fact/get" + "?access_token=\(accessToken)" + "&search_string=\(searchString)" + "&fact_type=\(factType)" + "&limit=\(limit)" + "&skip=\(skip)"
        
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func getFavFact(limit : Int, skip : Int, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        guard let me = LoginManager.share.me else { return }
        let accessToken = me.accessToken
        
        let path = AppConstants.currentServer + "fact/favourite/get" + "?access_token=\(accessToken)" + "&limit=\(limit)" + "&skip=\(skip)"
        
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func getPopularFact(limit : Int, skip : Int, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        guard let me = LoginManager.share.me else { return }
        let accessToken = me.accessToken
        
        let path = AppConstants.currentServer + "fact/get" + "?access_token=\(accessToken)" + "&limit=\(limit)" + "&skip=\(skip)" + "&fact_type=2"
        
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func submitFeedback(feedback : String, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        guard let me = LoginManager.share.me else { return }
        let accessToken = me.accessToken
        
        let path = AppConstants.currentServer + "feedback/add"
        let param : [String : Any] = ["access_token" : accessToken, "rating" : -1, "feedback" : feedback, "comments" : "", "device_type" : AppConstants.deviceType]
        
        HTTPRequest(method: .post, fullURLStr: path, parameters: param, encoding: .json, files: nil)
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE {
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func updateProfilePic(feedback : String, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        guard let me = LoginManager.share.me else { return }
        let accessToken = me.accessToken
        
        let path = AppConstants.currentServer + "feedback/add"
        let param : [String : Any] = ["access_token" : accessToken, "rating" : -1, "feedback" : feedback, "comments" : "", "device_type" : AppConstants.deviceType]
        
        HTTPRequest(method: .post, fullURLStr: path, parameters: param, encoding: .json, files: nil)
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE {
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func toggleNotificationSettings(notificationEnabled : Int, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        guard let me = LoginManager.share.me else { return }
        let accessToken = me.accessToken
        
        let path = AppConstants.currentServer + "user/editProfile"
        var param : [String : Any] = ["access_token" : accessToken, "notification_enabled" : notificationEnabled]
        let timeZoneInfo = AppConstants.timeZoneInfo
        let offset = AppConstants.timeZoneOffset
        let minutes = Int(offset/60)
        param["timezone"] = minutes
        param["timezone_info"] = timeZoneInfo
        
        HTTPRequest(method: .post, fullURLStr: path, parameters: param, encoding: .json, files: nil)
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE {
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func getUserAddedFacts(factStatus:Int,limit : Int, skip : Int, callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        guard let me = LoginManager.share.me else { return }
        let accessToken = me.accessToken
        
        let path = AppConstants.currentServer + "fact/userAddedfact" + "?access_token=\(accessToken)" + "&fact_status=\(factStatus)" + "&limit=\(limit)" + "&skip=\(skip)" 
        
        HTTPRequest(method: .get, fullURLStr: path, parameters: nil, encoding: .json, files: nil)
            .config(isIndicatorEnable: false, isAlertEnable: false)
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS {
                        guard let vc = LoginRouter.LoginVC() else {
                            return
                        }
                        let navigationController = UINavigationController()
                        navigationController.viewControllers = [vc]
                        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                            appDelegate.window?.rootViewController = navigationController
                        }, completion: nil)
                        callback(nil,nil)
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            callback(data, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
}
