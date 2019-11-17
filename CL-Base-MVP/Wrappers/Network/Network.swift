//
//  Network.swift
//  SylvanParent
//
//  Created by cl-macmini-79 on 24/11/17.
//  Copyright © 2017 Click-Labs. All rights reserved.
//

import Foundation
import Reachability

extension Notification.Name {
    /// chat manager notifications
    struct NetworkHandler {
        /// when network is reachable
        static let networkReachable = Notification.Name(rawValue: "clicklabs.NetworkHandler.networkReachable")
        /// when network is unreachable
        static let networkUnavailable = Notification.Name(rawValue: "clicklabs.NetworkHandler.networkUnavailable")
    }
}

class NetworkHandler {
    let reachability = try! Reachability()
    let statusAlert = BPStatusBarAlert(duration: 2.0, delay: 2, position: .statusBar)
    init() {
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name: Notification.Name.reachabilityChanged, object: reachability)
    }
    
    @objc func reachabilityChanged(note: NSNotification) {
        guard let reachability = note.object as? Reachability else {
            return
        }
        
        if reachability.isReachable {
            postReachableNotification()
        } else {
            postUnreachableNotification()
        }
    }
    
    func postUnreachableNotification() {
        self.showNoNetworkAlert()
        NotificationCenter.default.post(name: Notification.Name.NetworkHandler.networkUnavailable, object: nil)
    }
    
    func postReachableNotification() {
        showNetworkAvialable()
        NotificationCenter.default.post(name: Notification.Name.NetworkHandler.networkReachable, object: nil)
    }
    
    func showNoNetworkAlert() {
//        BPStatusBarAlert(duration: 0.3, delay: 2, position: .statusBar).message(message: NetworkError.noInternet.localizedDescription).messageColor(color: .white)
//            .bgColor(color: .spBtnPinkColor)
//            .font(font: UIFont.appFontRegular(size: 12)!)
//            .completion {
//            }
//            .show()
    }
    func showNetworkAvialable() {
//        BPStatusBarAlert(duration: 0.3, delay: 2, position: .statusBar).message(message: "Network Available".localized)
//            .messageColor(color: .white)
//            .font(font: UIFont.appFontRegular(size: 12)!)
//            .bgColor(color: .spBtnPinkColor)
//            .completion {
//                
//            }
//            .show()
    }
}
