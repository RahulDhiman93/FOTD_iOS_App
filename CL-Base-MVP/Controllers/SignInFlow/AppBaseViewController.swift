//
//  AppBaseViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 14/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class AppBaseViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = AppColor.themeSecondaryColor
        self.selectedIndex = 2
        // Do any additional setup after loading the view.
    }
    

}
