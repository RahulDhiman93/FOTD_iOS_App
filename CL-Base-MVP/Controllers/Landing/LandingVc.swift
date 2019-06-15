//
//  LandingVc.swift
//  CL-Base-MVP
//
//  Created by shubam garg on 03/04/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import UIKit

class LandingVc: UIViewController {

    var presenterDelegate: LandingPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let landingRouter = LandingRouterImplementation(with: self)
        self.presenterDelegate = LandingPresenterImplementation(router: landingRouter)
    }
    
   
   

    
    @IBAction func loginButonPressed(_ sender: Any) {
        presenterDelegate.loginPressed()
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        presenterDelegate.signUpPressed()
    }
}
