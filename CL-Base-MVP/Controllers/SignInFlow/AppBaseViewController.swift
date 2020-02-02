//
//  AppBaseViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 14/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit
import Hippo
import NotificationBannerSwift

class AppBaseViewController: UITabBarController {
    
    var arrayOfImageNameForSelectedState : [String] = ["home_default","add_default","today_default","search_default","more_default"]
    var arrayOfImageNameForUnselectedState : [String] = ["home_pressed","add_pressed","today_pressed","search_pressed","more_pressed"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBar.unselectedItemTintColor = AppColor.themeSecondaryColor
        self.selectedIndex = 2
        self.setupTab()
        self.registerPushNotification()
        // Do any additional setup after loading the view.
    }
    
    private func setupTab() {
        
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]

                let selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                let notSelectedImage = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
                

                
                self.tabBar.items?[i].selectedImage = selectedImage
                self.tabBar.items?[i].image = notSelectedImage
            }
        }

        let selectedColor   = AppColor.themePrimaryColor
        let unselectedColor = AppColor.themeSecondaryColor

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        
    }
    
}

extension AppBaseViewController {
    
    func registerPushNotification() {
        APNSManager.share.registerCallBack(for: self) { [weak self] (apnsResult) in
            switch apnsResult {
            case .forground(let userInfo):
                self?.showNotificationBanner(userInfo: userInfo)
                break
            case .background(let userInfo):
                let pushInfo = (userInfo.userJson) ?? [:]
                if HippoConfig.shared.isHippoNotification(withUserInfo: pushInfo) {
                    HippoConfig.shared.handleRemoteNotification(userInfo: pushInfo)
                    return
                }
                break
            }
        }
    }
    
    
    
    func showNotificationBanner(userInfo : APNSInfo) {
        guard let alert = userInfo.alert else {
            AlertPop.showAlert(alertBody: "notification error", leftButtonCallback: {
                
            }, rightButtonCallback: {
                
            })
            return
        }
        let banner = FloatingNotificationBanner(title: alert.title, subtitle: alert.body, titleColor: AppColor.themeSecondaryColor, subtitleColor: AppColor.themeSecondaryColor ,style: .info, colors: CustomBannerColors())
        banner.show()
        banner.haptic = .medium
        banner.onTap = {
            let pushInfo = (userInfo.userJson) ?? [:]
            if HippoConfig.shared.isHippoNotification(withUserInfo: pushInfo) {
                HippoConfig.shared.handleRemoteNotification(userInfo: pushInfo)
                return
            }
        }
    }

    
}

class CustomBannerColors: BannerColorsProtocol {

    internal func color(for style: BannerStyle) -> UIColor {
        switch style {
            case .danger:    return AppColor.themePrimaryColor
            case .info:        return AppColor.themePrimaryColor
            case .customView:    return AppColor.themePrimaryColor
            case .success:   return AppColor.themePrimaryColor
            case .warning:    return AppColor.themePrimaryColor
        }
    }

}
