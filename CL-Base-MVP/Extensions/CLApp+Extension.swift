//
//  CLApp+Extension.swift
//  CLApp
//
//  Created by Hardeep Singh on 12/4/16.
//  Copyright © 2016 Hardeep Singh. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import Alamofire

// MARK: -
var app: UIApplication {
  return UIApplication.shared
}

var appDelegate: AppDelegate {
  guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
    fatalError("AppDelegate is not UIApplication.shared.delegate")
  }
  return delegate
}

// MARK: - Reachability
class CLReachability {
  
  var networkReachabilityManager: NetworkReachabilityManager!
  static let reachabilty = CLReachability()
  
  // TODO: -
  //  public enum NetworkReachabilityStatus {
  //    case unknown
  //    case notReachable
  //    case reachable(ConnectionType)
  //  }
  //
  //  /// Defines the various connection types detected by reachability flags.
  //  ///
  //  /// - ethernetOrWiFi: The connection type is either over Ethernet or WiFi.
  //  /// - wwan:           The connection type is a WWAN connection.
  //  public enum ConnectionType {
  //    case ethernetOrWiFi
  //    case wwan
  //  }
  
  init() {
    if let networkReachabilityManager = NetworkReachabilityManager() {
      self.networkReachabilityManager = networkReachabilityManager
    }
  }
  
  class var isReachable: Bool {
    return CLReachability.reachabilty.networkReachabilityManager.isReachable
  }
  
  class var isReachableOnWWAN: Bool {
    return CLReachability.reachabilty.networkReachabilityManager.isReachableOnWWAN
  }
  
  class var isReachableOnEthernetOrWiFi: Bool {
    return CLReachability.reachabilty.networkReachabilityManager.isReachableOnEthernetOrWiFi
  }
  
  //  class var networkReachabilityStatus: NetworkReachabilityStatus {
  //      let reachbiltiy = CLReachability.reachabilty.networkReachabilityManager.networkReachabilityStatus
  //    return reachabilty
  //  }
  
}

extension AppDelegate {
  var isNetworkReachable: Bool {
    return CLReachability.isReachable
  }
}

extension AppDelegate {
  
  // MARK: -
  func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    
    if let nav = base as? UINavigationController {
      return topViewController(nav.visibleViewController)
    }
    
    if let tab = base as? UITabBarController {
      let moreNavigationController = tab.moreNavigationController
      
      if let top = moreNavigationController.topViewController, top.view.window != nil {
        return topViewController(top)
      } else if let selected = tab.selectedViewController {
        return topViewController(selected)
      }
    }
    
    if let presented = base?.presentedViewController {
      return topViewController(presented)
    }
    
    return base
  }
  
  func changeRootViewController(_ rootViewController: UIViewController, animated: Bool = true, from: UIViewController? = nil, completion: ((Bool) -> Void)? = nil) {
    let window = UIApplication.shared.keyWindow
    if let window = window, animated {
      UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
        let oldState: Bool = UIView.areAnimationsEnabled
        UIView.setAnimationsEnabled(false)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        UIView.setAnimationsEnabled(oldState)
      }, completion: completion)
    } else {
      window?.rootViewController = rootViewController
    }
  }
  
  /// Change rootViewController of main window after dismissing current controller ( if current controller was presented). This avoids keeping unused view controllers in hidden windows
  ///
  /// - Parameters:
  ///   - from: UIViewController from which to start the switch
  ///   - viewController: UIViewController to be set as new rootViewController
  ///   - completion: Handler to be executed when controller switch finishes
  func changeRootViewControllerAfterDismiss(_ from: UIViewController? = nil, to viewController: UIViewController, completion: ((Bool) -> Void)? = nil) {
    if let presenting = from?.presentingViewController {
      presenting.view.alpha = 0
      from?.dismiss(animated: false, completion: {
        self.changeRootViewController(viewController, completion: completion)
      })
    } else {
      changeRootViewController(viewController, completion: completion)
    }
  }
  
  // MARK: - Private
  private func infoDict() -> [String : Any]? {
    if let info = Bundle.main.infoDictionary {
      return info
    }
    return nil
  }
  
  // MARK: - Project Info
  var displayName: String {
    
    if let name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
      return name
    }

    if let name = Bundle.main.infoDictionary?["CFBundleName"] as? String {
      return name
    }
    
    return "Unknown".localized
  }
  
  var appVersion: String {
    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
      return version
    }
    if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
      return version
    }
    return "Unknown".localized
  }
  
  var bundle: String {
    if let info = self.infoDict() {
      return info[kCFBundleIdentifierKey as String] as? String ?? "Unknown".localized
    }
    return "Unknown".localized
  }
  
  var executable: String {
    if let info = self.infoDict() {
      return info[kCFBundleExecutableKey as String] as? String ?? "Unknown".localized
    }
    return "Unknown".localized
  }
  
  var build: String {
    if let info = self.infoDict() {
      return info[kCFBundleVersionKey as String] as? String ?? "Unknown".localized
    }
    return "Unknown".localized
  }
    
   var timeZoneOffset: String {
        return String((NSTimeZone.local.secondsFromGMT()*1000))
    }
  
  var osName: String {
    #if os(iOS)
      return "iOS"
    #elseif os(watchOS)
      return "watchOS"
    #elseif os(tvOS)
      return "tvOS"
    #elseif os(macOS)
      return "OS X"
    #elseif os(Linux)
      return "Linux"
    #else
      return "Unknown".localized
    #endif
  }
  
  var osVersion: String {
    let version = ProcessInfo.processInfo.operatingSystemVersion
    let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
    return versionString
  }
  
  func makePhoneCall(phoneNumber: String) -> Bool {
    let urlStr: String = "telprompt://\(phoneNumber)"
    if let url: URL = URL(string: urlStr),
      app.canOpenURL(url) {
      return app.openURL(url)
    }
    return false
  }
  
}
