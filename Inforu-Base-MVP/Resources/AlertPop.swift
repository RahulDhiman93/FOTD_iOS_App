//
//  AlertPop.swift
//  Inforu
//
//  Created by Rahul Dhiman on 27/11/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit

class AlertPop: NSObject {

    class func showAlert(alertTitle : String = "alert", alertBody : String , leftButtonTitle : String = "cancel", rightButtonTitle : String = "okay", isLeftButtonHidden : Bool = false, leftButtonCallback: @escaping () -> Void , rightButtonCallback: @escaping () -> Void) {
        let alertVc = AlertWithOptionsViewController.loadNibView(alertTitle: alertTitle, alertBody: alertBody, leftButtonTitle: leftButtonTitle, rightButtonTitle: rightButtonTitle, isLeftButtonHidden: isLeftButtonHidden)
        alertVc.leftButtonCallback(callback: { (_) in
            leftButtonCallback()
        })
        alertVc.rightButtonCallback(callback: { (_) in
            rightButtonCallback()
        })
        appDelegate.topViewController()?.present(alertVc, animated: true, completion: nil)
    }
    
}
