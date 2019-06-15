//
//  LocationTracker.swift
//  LocationTrackerWithCoreData28
//
//  Created by cl-mac-min-92 on 6/28/17.
//  Copyright © 2017 cl-mac-min-92. All rights reserved.
//
//  ****************** Version 1.0 ******************
// NSLocationWhenInUseUsageDescription
//NSLocationAlwaysAndWhenInUseUsageDescription
// Once you use earlier of ios10 then use NSLocationAlwaysUsageDescription

import Foundation
import CoreLocation
import UIKit
import CoreData

typealias AuthorizationStatusHandler = ((_ status: CLAuthorizationStatus) -> Void)
typealias LocationTrackerHandler = ((_ location: CLLocation) -> Void)

enum AuthorizationType {
    case whenInUse
    case always
}

class LocationTracker: NSObject {
    
    static let shared = LocationTracker()
    let horizontalAccuracy: Double = 20.0
    
    fileprivate var locationManager: CLLocationManager?
    fileprivate var lastLocation: CLLocation?
    fileprivate var persistentStore: PersistentStoreLocation = PersistentStoreLocation()
    
    var isBackground = false
    var isSave = false
    var lastSpeed: Double = 0.0
    var currentLocation: CLLocation? {
        return lastLocation
    }
    var shareModel: LocationShareModel = LocationShareModel.sharedModel
    
    // CallBacks
    fileprivate var authorizationStatusHandler: AuthorizationStatusHandler?
    fileprivate var locationTrackerHandler: LocationTrackerHandler?
    
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        super.init()
        self.locationManager = locationManager
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager?.distanceFilter = 20
        
        // Get LastLocation
        self.lastLocation = self.persistentStore.getLastLocation()
        
        //
        NotificationCenter.default.addObserver(self, selector: #selector(LocationTracker.applicationEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
    }
    
    // MARK: - Public API
    func didChangeAuthorizationStatus(callback: @escaping AuthorizationStatusHandler) {
        self.authorizationStatusHandler = callback
    }
    
    func didChangeLocation(callback: @escaping LocationTrackerHandler) {
        self.locationTrackerHandler = callback
    }
    
    
    func startLocationTracker() {
        
        if self.isBackground == true {
            locationManager?.allowsBackgroundLocationUpdates = true
        }
        // self.escalateLocationServiceAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    func stopLocationTracker() {
        
        if self.isBackground == true {
            locationManager?.allowsBackgroundLocationUpdates = false
        }
        locationManager?.stopUpdatingLocation()
        self.shareModel.bgTask?.endBackgroundTasks()
        
    }
    
    
    
    func requestLocationWithAuthorization(type: AuthorizationType, callback: @escaping AuthorizationStatusHandler) {
        self.authorizationStatusHandler = callback
        let authorizationStatus =  CLLocationManager.authorizationStatus()
        switch type {
        case .always:
            if authorizationStatus == .notDetermined {
                self.locationManager?.requestAlwaysAuthorization()
            } else {
                self.locationManager?.requestAlwaysAuthorization()
            }
        case .whenInUse:
            if authorizationStatus != .authorizedWhenInUse {
                self.locationManager?.requestWhenInUseAuthorization()
            }
        }
    }
    
    func escalateLocationServiceAuthorization() {
        // Escalate only when the authorization is set to when-in-use
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.locationManager?.requestAlwaysAuthorization()
        }
    }
    
    // MARK: - Private APIs
    
    // MARK: - Application State changed
    fileprivate func startBackGroundTask() {
        if self.isBackground == true {
            self.shareModel.bgTask = LocationBackgroundTaskManager.shared
            self.shareModel.bgTask?.beginNewBackgroundTask()
        }
    }
    
    @objc private func applicationEnterBackground() {
        self.startBackGroundTask()
    }
    
    
    // function to open the Settings in app
    private func openSettings() {
        if #available(iOS 10.0, *) {
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    //Show alert when case is denied
    fileprivate func showAlertForChangeAuthorization() {
        UIAlertController.showAlert(title: "Change Your AuthorizationStatus",
                                    message: "Location Authorization Denied",
                                    style: .alert).action(title: "Ok",
                                                          style: .default, handler: { (alert: UIAlertAction) in
                                                            self.openSettings()
                                    })
    }
    
}

// MARK: - Store Presistent
extension LocationTracker {
    
    func removeAllLocalLocations(locations: [Location]) {
        self.persistentStore.removeObjects(list: locations)
    }
    
    func removeAllLocalLocations() {
        self.persistentStore.removeAllLocations()
    }
    
    func getSavedLocations(limit: Int = 0, ascending: Bool, callBack: @escaping (_ locations: [Location]) -> Void) {
        let list = self.persistentStore.getSavedLocations(limit: limit, ascending: ascending)
        callBack(list)
    }
    
}


// MARK: - CLLocationManagerDelegate
extension LocationTracker: CLLocationManagerDelegate {
    
    // TODO: didFailWithError
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Not Accessed \(error)")
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
        switch status {
        case .notDetermined:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            self.startLocationTracker()
            break
        case .restricted, .denied:
            self.stopLocationTracker()
            showAlertForChangeAuthorization()
            break
        }
        authorizationStatusHandler?(status)
    }
    
    private func useAbleLocation(newLocation: CLLocation) {
        if self.isSave == true {
            self.persistentStore.save(location: newLocation)
        }
        self.locationTrackerHandler?(newLocation)
    }
    
    private func validLocation(location: CLLocation) -> Bool {
        let howRecent = location.timestamp.timeIntervalSinceNow
        guard CLLocationCoordinate2DIsValid(location.coordinate),
            location.horizontalAccuracy > 0,
            location.horizontalAccuracy < horizontalAccuracy,
            abs(howRecent) < 10 else { return false }
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for newLocation in locations {
            
            guard let lastLocationIs =  self.lastLocation else {
                
                //First time get location
                //Save Location
                if validLocation(location: newLocation) {
                    self.lastLocation = newLocation
                    self.useAbleLocation(newLocation: newLocation)
                }
                return
            }
            
            let distance = (newLocation.distance(from: lastLocationIs))
            if distance <= 0 {
                return
            }
            
            //Save Location
            if validLocation(location: newLocation) {
                self.lastLocation = newLocation
                self.useAbleLocation(newLocation: newLocation)
            }
            
            // Create bacground task...
            if CLLocationManager.authorizationStatus() == .authorizedAlways {
                self.startBackGroundTask()
            }
        }
    }
}

// MARK: - Alert Controller
extension UIAlertController {
    
    fileprivate func presentAlertController() {
        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
    }
    
    @discardableResult
    fileprivate class func showAlert(title: String?, message: String?, style: UIAlertControllerStyle) -> UIAlertController {
        let alertController = UIAlertController.alert(title: title, message: message, style: style)
        alertController.presentAlertController()
        return alertController
    }
    
}

