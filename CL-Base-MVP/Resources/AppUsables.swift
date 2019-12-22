//
//  AppUsables.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class AppUsables: NSObject {

    class func shareFact(fact : String) {
        
        let shareFact = "\(fact) \n\nDownload FOTD from Play Store:\nhttps://play.google.com/store/apps/details?id=com.indemand.fotd \n\nDownload FOTD from App Store:\nhttps://itunes.apple.com/az/app/fact-of-the-day-new-facts/id1450758752?mt=8"
        
        let shareActivityViewController = UIActivityViewController(activityItems: [shareFact], applicationActivities: nil)
        
        shareActivityViewController.completionWithItemsHandler = { activity, completed, items, error in
            
            if completed {
                FirebaseEvents.shareEvent(sharedOn: activity.debugDescription, sharedFact: fact)
                shareActivityViewController.dismiss(animated: true, completion: nil)
            }
        }
        guard let topVC = appDelegate.topViewController() else { return }
        
        if let popoverController = shareActivityViewController.popoverPresentationController {
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.sourceView = topVC.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        
        topVC.present(shareActivityViewController, animated: true, completion: nil)
    }
    
}
