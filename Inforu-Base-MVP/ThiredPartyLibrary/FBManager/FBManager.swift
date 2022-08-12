//
//  FacebookManager.swift
//  BeGlammed CP
//
//  Created by Socomo on 12/19/16.
//  Copyright © 2016 Hardeep Singh. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

typealias FacebookManagerCallBack = ((_ error: Error?, _ response: Any?) -> Void)
typealias FacebookPermissionCallBack = ((_ access: Bool) -> Void)
class FacebookManager: NSObject {
  
  static let share = FacebookManager()
  private var readPermissions: [String]
  let login = FBSDKLoginKit.LoginManager()
  
  override init() {
    self.readPermissions = ["public_profile", "email", "user_birthday"]
  }
  
  //TODO: Facebbok Login and Fetch Profile Methods
  
  /// Method will Fetch user facebook profile info
  /// If user not currently login with Facebbok firstly ask user to login and provide access to read profile Info.
  /// - Parameters:
  ///   - controller: Current calling controller
  ///   - handler: Callback with profile info as result or Error
  
  func getUserProfile(from controller: UIViewController, handler: @escaping FacebookManagerCallBack) {
    controller.view.endEditing(true)
    let accessToken = AccessToken.current
    if accessToken != nil {
      self.fetchUserProfile(handler: { (error, response) in
        print("Response \(String(describing: response))")
        handler(error, response)
      })
    } else {
      
      loginWithReadPermission(from: controller, handler: { (isPermissionGranter) in
        
        if isPermissionGranter {
        let accessToken = AccessToken.current
          if accessToken != nil {
            CLProgressHUD.present(animated: true)
            self.fetchUserProfile(handler: { (error, response) in
                CLProgressHUD.dismiss(animated: true)
              print("Response \(String(describing: response))")
              handler(error, response)
            })
          }
        } else {
          // Permission not granted
        }
      })
      
      //            loginWithReadPermission(from: controller, handler: { (error, result) in
      //                let accessToken = FBSDKAccessToken.current()
      //                if accessToken != nil {
      //                    self.fetchUserProfile(handler: { (error, response) in
      //                        print("Response \(response)")
      //                        handler(error,response)
      //                    })
      //                }
      //                else {
      //                    /// Error while fetching Profile Info
      //                }
      //
      //            })
    }
  }
  
  /// Method acees permission from user to read public profile info
  ///
  /// - Parameters:
  ///   - controller: calling controller
  ///   - handler: Callback with read permissin as result or Error
  func loginWithReadPermission(from controller: UIViewController, handler: @escaping FacebookPermissionCallBack ) {
    
    login.logOut()
    
    login.logIn(permissions: self.readPermissions, from: controller) { (result, error) -> Void in
      
      if error != nil {
        NSLog("error \(String(describing: error?.localizedDescription))")
        // AlertViewHelper.makingAlertView("", message: "error.description as String")
      } else {
        if result?.grantedPermissions != nil {
          
          handler(true)
          //logout from facebook server
          
        } else if result?.isCancelled == true {
          handler(false)
          // stopProcessing()
          // AlertViewHelper.makingAlertView("", message: "Login Cancelled")
        } else {
          handler(false)
        }
      }
      
    }
  }
  
  /// Fetch user profile Info it user already give profile read permission.
  ///
  /// - Parameter handler: Callback with Profile Info as result or Error
  private func fetchUserProfile(handler: @escaping FacebookManagerCallBack) {
    
    if CLReachability.isReachable {
      
        if AccessToken.current != nil {
        //showActivityIndicator(view)
        let param =  ["fields": "email,name,first_name,last_name,picture.width(720).height(720)"]
            GraphRequest(graphPath: "me", parameters: param).start { connection, result, error in
          if !(error != nil) {
            handler(nil, result)
          } else {
            NSLog("error \(String(describing: error?.localizedDescription))")
            handler(error, nil)
          }
        }
      } else {
        // Error while fetching user Info
      }
    } else {
      //AlertViewHelper.makingAlertView("", message: "Please check your internet connection.")
    }
  }
  
  /// Revoke permission accessed from user
  ///
  /// - Parameter handler: Callback with Revoke permission Info as result or Error
  func revokePermissions(handler: @escaping FacebookManagerCallBack) {
    GraphRequest(graphPath: "me/permissions", parameters: ["accessToken" : AccessToken.current?.tokenString ?? ""], httpMethod: HTTPMethod(rawValue: "DELETE")).start { (connection, result, error) in
        print("GRAPH REVOKE REQUEST ---->>")
        print(connection)
        print(result)
        print(error)
      handler(error, result)
    }
    
  }
  
  /// Logout user from facebook App and revoke read public profile info.
  func logout(revokePermissions: Bool) {
    
    if revokePermissions == true {
      self.revokePermissions { (error, result) in
        self.login.logOut()
      }
    } else {
        self.login.logOut()
    }
  }
  
  //TODO: Sharing With Facebook
  
  /// Share content with facebook
  ///
  /// - Parameters:
  ///   - urlStr: Image or video URL string
  ///   - title: Title of sharing post
  ///   - description: Description of sharing post
  ///   - controller: Calling controller
  
  
}

//if let extractedResult = result as? NSDictionary {
//
//    FBSDKGraphRequest(graphPath: "me?fields=picture.width(720).height(720)", parameters: nil).start{
//        connection,response,error in
//        if (error == nil) {
//            if let pictureResult = response as? [String:Any] {
//                if let extractedResult = pictureResult["picture"] as? [String:Any] {
//                    print(extractedResult)
//                    if let imageData = extractedResult["data"]! as? [String:Any] {
//
//                        let mutableDict : NSMutableDictionary = NSMutableDictionary(dictionary: extractedResult)
//                        mutableDict.setObject(imageData["url"] ?? "", forKey: "picture" as NSCopying)
//                        handler(error!,result)
//
//
//                        //                            self.facebookImageUrl = imageData["url"]! as! String
//                        //                            print(self.facebookImageUrl)
//                    }
//                }
//            }
//
//        }
//        else {
//            handler(error!,extractedResult)
//        }
//
//    }
//
//}
