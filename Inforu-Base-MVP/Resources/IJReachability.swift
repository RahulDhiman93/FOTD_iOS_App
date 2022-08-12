//
//  IJReachability.swift
//  Inforu
//
//  Created by Rahul Dhiman on 21/06/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation
import SystemConfiguration

public enum IJReachabilityType {
    case WWAN,
    WiFi,
    NotConnected
}

public class IJReachability {
    
    /**
     :see: Original post - http://www.chrisdanielson.com/2009/07/22/iphone-network-connectivity-test-example/
     */
    public class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        //let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        //   SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        // }
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                
                SCNetworkReachabilityCreateWithAddress(nil, $0)
                
            }
            
        }) else {
            
            return false
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags.connectionAutomatic
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection) ? true: false
    }
    
    public class func isConnectedToNetworkOfType() -> IJReachabilityType {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        // let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        //   SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        // }
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                
                SCNetworkReachabilityCreateWithAddress(nil, $0)
                
            }
            
        }) else {
            
            return .NotConnected
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags.connectionAutomatic
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .NotConnected
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let isWWAN = (flags.rawValue & UInt32(SCNetworkReachabilityFlags.isWWAN.rawValue)) != 0
        //let isWifI = (flags & UInt32(kSCNetworkReachabilityFlagsReachable)) != 0
        
        if isReachable && isWWAN {
            return .WWAN
        }
        if isReachable && !isWWAN {
            return .WiFi
        }
        
        return .NotConnected
        //let needsConnection = (flags & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        //return (isReachable && !needsConnection) ? true: false
    }
    
}

