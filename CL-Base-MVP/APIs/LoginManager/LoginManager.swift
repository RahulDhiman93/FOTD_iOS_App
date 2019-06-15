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
        let appName = appDelegate.displayName
        return "com.\(appName).login_manager"
    }
    let headerWithoutAuth = ["utcoffset": appDelegate.timeZoneOffset, "content-language": appDelegate.currentlanguage]
    
    /// Return true for valid access token, otherwise retrun false
    open var isAccessTokenValid: Bool {
        if self.me != nil {
            return true
        }
        return false
    }
    
    //Singleton initialization to ensure just one instance is created.
    private init() {
        
        persistencyManager = PersistencyManager()
        keychain = Keychain(service: LoginManager.keychainServiceName)
        
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
        keychain[kAccessToken] = me.accessToken
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
    func login(parameter: [String: Any], callBack: @escaping LoginManagerCallBack) {
        let param = appendDeviceInfo(param: parameter)
        HTTPRequest(method: .post,
                    path: "parent/login",
                    parameters: param,
                    encoding: .json,
                    files: nil)
            .config(isIndicatorEnable: true, isAlertEnable: true)
            .headers(headers: headerWithoutAuth)
            .handler(httpModel: false, delay: 0.0) { (response: HTTPResponse) in
                self.updateUserProfile(response: response, callBack: callBack)
        }
    }
    
    func signup(parameters: [String: Any], callBack: @escaping LoginManagerCallBack) {
        let signupParam = appendDeviceInfo(param: parameters)
        print(signupParam)
        HTTPRequest(method: .post, path: "parent/register", parameters: signupParam,
                    encoding: EncodingType.json, files: nil)
            .config(isIndicatorEnable: true, isAlertEnable: false)
            .headers(headers: headerWithoutAuth)
            .multipartHandler(httpModel: false) { (response: HTTPResponse) in
                self.updateUserProfile(response: response, callBack: callBack)
        }
    }
    
    func logout(callBack: @escaping LoginManagerCallBack) {
        HTTPRequest(method: .post, path: "user/logout", parameters: nil, encoding: .url, files: nil)
            .handler { (response: HTTPResponse) in
                if response.error != nil {
                    callBack(nil, response.error)
                    return
                }
                if let value = response.value {
                    self.afterLogout()
                    callBack(value, nil)
                }
        }
    }
    
}
