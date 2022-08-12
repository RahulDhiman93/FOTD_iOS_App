//
//  VersionManager.swift
//  CLApp
//  Created by cl-macmini-79 on 24/05/17.
//  Copyright © 2017 Click-labs. All rights reserved.
//
//*****************************  Version:- 1.0  *****************************
//

import Foundation
import UIKit

class VersionManager {
    
    private var newVersion: String
    private var forceUpdateVersion: String
    private var message: String = "NewVersionAvailable".localized
    private var showMessage: Bool = true
    private var appStoreUrl: String
    
    init(newVersion: String, forceUpdateVersion: String, appStoreURL: String) {
        self.newVersion = newVersion
        self.forceUpdateVersion = forceUpdateVersion
        self.appStoreUrl = appStoreURL
    }
    
    func message(message: String) -> VersionManager {
        self.message = message
        return self
    }
    
    func config(showAlert: Bool) -> VersionManager {
        self.showMessage = showAlert
        return self
    }
    
    func appStoreURL(url: String) -> VersionManager {
        self.appStoreUrl = url
        return self
    }
    
    func newVersionAvailable(result: (Bool) -> Void) {
        if forceUpdateVersion > appDelegate.appVersion {
            if showMessage {
                showAlertForForceUpdate()
            }
            result(true)
        } else {
            checkForLatestVersion()
        }
        result(false)
    }
    
    private func checkForLatestVersion() {
        if newVersion > appDelegate.appVersion {
            if showMessage {
                self.showAlert()
            }
        }
    }
    
    private func showAlertForForceUpdate() {
        let alertController = UIAlertController(title: "Update".localized, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Update".localized, style: .default, handler: { (_) in
            self.gotoAppStore()
        })
        alertController.addAction(defaultAction)
        appDelegate.topViewController()?.present(alertController, animated: true, completion: {
        })
    }
    
    private func showAlert() {
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title: "Update".localized, message: self.message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Later".localized, style: .default, handler: nil)
            alertController.addAction(defaultAction)
            let updateAction = UIAlertAction(title: "Update".localized, style: .default, handler: { (_) in
                self.gotoAppStore()
            })
            alertController.addAction(updateAction)
            appDelegate.topViewController()?.present(alertController, animated: true, completion: {
            })
        })
    }
    
    private func gotoAppStore() {
        guard let url  = URL(string: appStoreUrl) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) == true {
            UIApplication.shared.openURL(url)
        }
    }
    
}
//
// HOW USE VersionManager
// Example:- 
class CheckCode {
    
    func checkVersion() {
        let version = VersionManager(newVersion: "1.0.0", forceUpdateVersion: "1.0.0", appStoreURL: "")
        version.message(message: "anything").config(showAlert: true).newVersionAvailable { force in
            if force {
                // Do not let user go inside the app
            } else {
                // let the user continue
            }
        }
    }
    
}
