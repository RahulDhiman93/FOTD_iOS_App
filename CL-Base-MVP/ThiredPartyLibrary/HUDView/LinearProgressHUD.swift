//
//  LinearProgressHUD.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit
import LinearProgressBarMaterial

class LinearProgressHUD: NSObject {

    static var sharedView = LinearProgressHUD()
    let linearBar: LinearProgressBar = LinearProgressBar()
    
    func present(animated: Bool)  {
        self.linearBar.backgroundColor = AppColor.themePrimaryColor
        self.linearBar.progressBarColor = AppColor.themeSecondaryColor
        self.linearBar.heightForLinearBar = 7
        self.linearBar.startAnimation()
    }
    
    func dismiss(animated: Bool) {
        self.linearBar.stopAnimation()
    }
    
}
