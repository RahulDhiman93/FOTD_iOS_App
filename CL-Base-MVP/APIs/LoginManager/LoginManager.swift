//
//  LoginManager.swift
//  CLApp
//
//  Created by Hardeep Singh on 12/4/16.
//  Copyright © 2016 Hardeep Singh. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import KeychainAccess

//Protocol
protocol LoginManagerRoules {
    var requestHeaders: [String: String]? {get}
}

extension Notification.Name {
    struct LoginManagerStatus {
        static let logout = Notification.Name(rawValue: "clicklabs.LoginManager.logout")
        static let unauthorized = Notification.Name(rawValue: "clicklabs.LoginManager.unauthorized")
    }
}

let kAccessToken: String = "AccessToken"
let dummy       : String = "dummy"
typealias LoginManagerCallBack = ((_ response: Any?, _ error: Error?) -> Void)

final class LoginManager: LoginManagerRoules {
    
    // MARK: -
    private(set) var me: Me?
    
    //: --
    static let share = LoginManager()
    private let persistencyManager: PersistencyManager<Me>
    private let keychain: Keychain
    class private var fileName: String {
        return "user.bin"
    }
    class private var keychainServiceName: String {
        let appName = AppConstants.appName
        return "com.\(appName).login_manager"
    }
    let headerWithoutAuth = ["utcoffset": appDelegate.timeZoneOffset, "content-language": appDelegate.currentlanguage]
    
    /// Return true for valid access token, otherwise retrun false
    public var isAccessTokenValid: Bool {
        if self.me != nil {
            return true
        }
        return false
    }
    
    //Singleton initialization to ensure just one instance is created.
    private init() {
        
        persistencyManager = PersistencyManager()
        keychain = Keychain(service: LoginManager.keychainServiceName)
        
        
        guard let dummy = keychain[dummy] else {
            return
        }
        print(dummy)
        
        guard let token = keychain[kAccessToken] else {
            removeUserProfile()
            return
        }
        
        let fileURL: URL = getFilePath()
        guard let me = persistencyManager.getObject(fileURL: fileURL) else {
            removeUserProfile()
            return
        }
        
        self.me = me
        self.me?.accessToken = token
        
        //HTTP Request unauthorized....
        NotificationCenter.default.addObserver(self, selector: #selector(LoginManager.afterUnauthorized), name: Notification.Name.HTTPRequestStatus.unauthorized, object: nil)
        
    }
    
    /// Access token.
    final var requestHeaders: [String: String]? {
        var headers = ["content-language": "en"]
        if let accessToken = self.me?.accessToken {
            headers["authorization"] = "bearer \(accessToken)"
        }
        return headers
    }
    
    func appendDeviceInfo(param: Modelable) -> Modelable {
        var parameters = param
        parameters["deviceType"] = "IOS"
        parameters["deviceName"] = "iPhone"
        parameters["deviceToken"] = "fsdfds"
        return parameters
    }
    
    //Persistency storage.
    private func getFilePath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var documentsDirectory = paths[0]
        documentsDirectory.appendPathComponent(LoginManager.fileName)
        return documentsDirectory
    }
    
    func saveProfile() {
        guard let me = self.me else {
            return
        }
        let fileURL: URL = getFilePath()
        let saved = persistencyManager.save(url: fileURL, object: me)
        print("----> saved \(saved)")
        keychain[dummy] = "123456"
        if me.accessToken != "" {
            keychain[kAccessToken] = me.accessToken
        }
    }
    
    private func removeUserProfile() {
        let fileURL: URL = getFilePath()
        persistencyManager.removeObject(url: fileURL)
        
        do {
            try keychain.remove(kAccessToken)
        } catch {
            print("KEYCHAIN NOT REMOVE")
            return
        }
        
        me = nil
    }
    
    private func afterLogin() {
        self.saveProfile()
    }
    
    @objc private func afterUnauthorized() {
        self.removeUserProfile()
        NotificationCenter.default.post(name: Notification.Name.LoginManagerStatus.unauthorized, object: nil)
    }
    
    @objc private func afterLogout() {
        // TODO: Use the current user's information
        self.removeUserProfile()
        NotificationCenter.default.post(name: Notification.Name.LoginManagerStatus.logout, object: nil)
        //Notification unregister
        //diable location
    }
    
    private func updateUserProfile(response: HTTPResponse, callBack: LoginManagerCallBack) {
        if response.error != nil {
            callBack(nil, response.error)
            return
        }
        
        if let jsonObject = response.value as? [String: Any],
            let data = jsonObject["data"] as? [String: Any] {
            let me = Me(with: data)
            self.me = me
            self.afterLogin()
        }
        callBack(response.value, nil)
    }
    
    // MARK: - Server requests
    //Public Apis
    func loginFromEmail(param: [String: Any], callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        let path = AppConstants.currentServer + "user_login"
        
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
                        
                        if statusCode == 1 {
                            if let jsonObject = value as? [String: Any],
                                let data = jsonObject["data"] as? [String: Any] {
                                let me = Me(with: data)
                                self.me = me
                                self.afterLogin()
                                callback(jsonObject, nil)
                            } else {
                                callback(nil, nil)
                            }
                        } else {
                            callback(nil,nil)
                        }
                    }


        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func signUpFromEmail(param: [String: Any], callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        let path = AppConstants.currentServer + "user_sign_up"
        
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
                    
                    if statusCode == 1 {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            let me = Me(with: data)
                            self.me = me
                            self.afterLogin()
                            callback(jsonObject, nil)
                        } else {
                            callback(nil, nil)
                        }
                    } else {
                        callback(nil,nil)
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func loginFromAccessToken(callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        var param : [String : Any] = [:]
        let path = AppConstants.currentServer + "user_access_token_login"
        
        guard let me = LoginManager.share.me else {
            return
        }
        
        print("\n----------accessToken Data------------\n")
        print(me.accessToken)
        print("\n")
        print(AppConstants.deviceToken)
        print("\n")
        
        param["access_token"] = me.accessToken
        
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
                    
                    if statusCode == 1 {
                        if let jsonObject = value as? [String: Any],
                            let data = jsonObject["data"] as? [String: Any] {
                            let me = Me(with: data)
                            self.me = me
                            self.afterLogin()
                            callback(jsonObject, nil)
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
