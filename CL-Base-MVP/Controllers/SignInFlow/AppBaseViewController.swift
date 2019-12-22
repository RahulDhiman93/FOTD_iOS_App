//
//  AppBaseViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 14/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class AppBaseViewController: UITabBarController {
    
    var arrayOfImageNameForSelectedState : [String] = ["home_default","add_default","today_default","search_default","more_default"]
    var arrayOfImageNameForUnselectedState : [String] = ["home_pressed","add_pressed","today_pressed","search_pressed","more_pressed"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBar.unselectedItemTintColor = AppColor.themeSecondaryColor
        self.selectedIndex = 2
        self.setupTab()
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
