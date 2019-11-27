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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION {
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION {
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION {
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION {
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION {
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
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION {
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
