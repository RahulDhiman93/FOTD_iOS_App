//
//  APNSManager.swift
//  APNSManager
//
//  Created by Click-Labs on 22/04/17.
//  Copyright © 2017 Click-Labs. All rights reserved.
//

// APNSManager Version 1.0.1

import Foundation
import UIKit
import UserNotifications

protocol Alert {
  var title: String? {get set}
  var body: String? {get set}
  var alertText: String? {get set}
}

protocol APNSPayload {
  var alert: Alert? {get set}
  var sound: String? {get set}
  var badge: Int {get set}
  var contentAvailable: Bool {get set}
  init(userInfo: [AnyHashable: Any])
}

public enum APNSResult<ApnsInfo> {
  case forground(ApnsInfo)
  case background(ApnsInfo)
}

protocol NotificationHandler {
  func failedToRegisterForNotifications(error: Error)
  func successfullyRegisteredForNotifications(data: Data)
}

extension NotificationHandler {
  func failedToRegisterForNotifications(error: Error) {
    debugPrint("Error registering for notifications \(error)")
  }
}

typealias APNSManagerCallBack = ((_ info: APNSResult<APNSInfo>) -> Void)

final class APNSManager: NSObject, NotificationHandler {
  
  //Share instance.
  static let share = APNSManager()
  
  // Queue for new notifications.
  private var queue: [APNSResult<APNSInfo>] = []
  
  // APNS device token
  private(set) var deviceToken: String? {
    didSet {
      UserDefaults.standard.set(self.deviceToken, forKey: "AppDeviceToken")
      UserDefaults.standard.synchronize()
    }
  }
  
  // register callback
  private var callBacks: [AnyHashable: APNSManagerCallBack] = [:]
  
  // flag for set waiting for next notifications.
  var sayForWaiting: Bool = false
  
  private override init() {}
  
  func registerAppRemoteNotifications() {
    let app = UIApplication.shared
    
    // iOS 10 support
    if #available(iOS 10, *) {
      UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in }
      UNUserNotificationCenter.current().delegate = self
      app.registerForRemoteNotifications()
    }
      // iOS 9 support
    else if #available(iOS 9, *) {
      app.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
      app.registerForRemoteNotifications()
    }
      // iOS 8 support
      //        else if #available(iOS 8, *) {
      //            app.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
      //            app.registerForRemoteNotifications()
      //        }
      // iOS 7 support
    else {
      app.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
    }
    
  }
  
  func unregisterAppRemoteNotifications() {
    let app = UIApplication.shared
    app.unregisterForRemoteNotifications()
  }
  

  func successfullyRegisteredForNotifications(data: Data) {
    let deviceTokenString = data.reduce("", {$0 + String(format: "%02X", $1)})
    deviceToken = deviceTokenString
    print("Device Token --", deviceToken ?? "Device token is nil")
  }
  
  func next() {
    guard let info = self.queue.first  else {
      return
    }
    
    if self.callBacks.count > 0 {
      for (_, callBack) in self.callBacks {
        callBack(info)
      }
      _ = self.queue.removeFirst()
    }
  }
  
  /// <#Description#>
  ///
  /// - Parameter payload: <#payload description#>
  func add(notification payload: APNSResult<APNSInfo>) {
    queue.append(payload)
    
    switch payload {
    case .background(_):
      self.next()
    default:
      if sayForWaiting == false {
        self.next()
      }
    }
  }
  
  func removeAllPendingNotifications() {
    self.queue.removeAll()
  }
  
  func registerCallBack(for object: AnyObject, callBack: @escaping APNSManagerCallBack) {
    let hashString = String(describing: type(of: object))
    if self.callBacks[hashString] != nil {
       self.next()
      return
    }
    self.callBacks[hashString] = callBack
    self.next()
  }
  
  func removeOserver(object: AnyObject) {
    let hashString = String(describing: type(of: object))
    self.callBacks[hashString] = nil
  }
  
}

// MARK: - didReceiveRemoteNotification completionHandler
extension APNSManager {
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    
    if application.applicationState == .inactive || application.applicationState == .background {
      let info = APNSInfo(userInfo: userInfo)
      let result  = APNSResult.background(info)
      APNSManager.share.add(notification: result)
    } else {
      let info = APNSInfo(userInfo: userInfo)
      let result  = APNSResult.forground(info)
      APNSManager.share.add(notification: result)
    }
    completionHandler(.noData)
  }
  
}

// MARK: - UNUserNotificationCenterDelegate
extension APNSManager: UNUserNotificationCenterDelegate {
  
  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (_ options: UNNotificationPresentationOptions) -> Void) {
    print("Handle push from foreground")
    // custom code to handle push while app is in the foreground
    print("\(notification.request.content.userInfo)")
    let userInfo = notification.request.content.userInfo
    let info = APNSInfo(userInfo: userInfo)
    let result  = APNSResult.forground(info)
    APNSManager.share.add(notification: result)
    completionHandler([.sound])
  }
  
  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    print("Handle push from background or closed")
    print("\(response.notification.request.content.userInfo)")
    let userInfo = response.notification.request.content.userInfo
    let info = APNSInfo(userInfo: userInfo)
    let result  = APNSResult.background(info)
    APNSManager.share.add(notification: result)
    completionHandler()
  }
  
}
