//
//  AppConstants.swift
//  Inforu
//
//  Created by Rahul Dhiman on 21/06/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

// MARK: - Shared Instance
class GoogleMapUsage {
    static let sharedInstance = GoogleMapUsage()
    var globalMapView = GMSMapView()
}



struct AppConstants {
    static let appName = "FOTD"
    static let DeviceOS = "iOS"
    static let deviceType = 1
    static let hippoAppType = "1" //1 for iOS -- 2 for Android
    static let deviceName = UIDevice.current.name
    static let appVersion = 45
    static let timeZoneInfo = TimeZone.current.description
    static let timeZoneOffset = TimeZone.current.secondsFromGMT()
    static let KeyboardDistanceFromTextfield: CGFloat = 40
    static var kAccessToken: String = "AccessToken"
    static let empID : Int = 11
    static let googlePlacesKey: String = "AIzaSyAxOOXIWGsNX1LiRgRpp1TJhe1JO20dEoc"
    static let googleMapKey: String = "AIzaSyAxOOXIWGsNX1LiRgRpp1TJhe1JO20dEoc"
    static let countryCode = "+91"
    static let currencySymbol = "₹"
    static let phoneNumberDigit: Int = 10
    static let additionalFieldsSmallLimit : Int = 14
    static let additionalFieldsBigLimit : Int = 49
    static let additionalFieldsCharaters = 0
    static let additionalFieldsRUTLimit : Int = 10
    static let referanceTextCharacters = 139
    static let feedbackCharactersCount : Int = 239
    static let regexConstant = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ-.@0123456789_"
    static let alphabetConstant = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ"
    static var deviceToken = "deviceToken"
    static let currentServer = Config.sharedInstance.baseURL()
    static var aboutUs = ""
    static var instgramLink = ""
    static let placeHolderUrl = "https://s3.ap-south-1.amazonaws.com/mahindra-ebike/dev/user/original_F1@oBZ5jT1545373576604.png"
}

struct STATUS_CODES {
    static let INVALID_ACCESS_TOKEN = 101
    static let BAD_REQUEST = 400
    static let UNAUTHORIZED_ACCESS = 401
    static let PICKUP_TASK = 410
    static let ERROR_IN_EXECUTION = 500
    static let SHOW_ERROR_MESSAGE = 304
    static let NOT_FOUND_MESSAGE = 404
    static let UNAUTHORIZED_FOR_AVAILABILITY = 210
    static let SHOW_MESSAGE = 201
    static let SHOW_DATA = 200
    static let SLOW_INTERNET_CONNECTION = 999
    static let DELETED_TASK = 501
    static let WSOTPVerificationPendingStatus = 100
}

struct USER_DEFAULT {
    static let DeviceToken = "deviceToken"
    static let userLatitude = "userLatitude"
    static let userLongitude = "userLongitude"
    static let isLocationFetched = "isLocationFetched"
    static let accessTokenExist = "accessTokenExist"
}


struct UIKitContant {
    static var rootNavigationController :UINavigationController? = nil
}

enum StatusCode:Int {
    case success = 200
    case `default`
    static func getEnum(rawValue:Int) -> StatusCode? {
        switch rawValue {
        case 200:
            return success
        default:
            return nil
        }
    }
}
