//
//  ViewController.swift
//  CL-Base-MVP
//
//  Created by Deepak Sharma on 11/27/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    weak var loginRouterDelegate = login

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func signUPButtonPressed() {
        if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    
    /* you can setup delegate of the upcoming controller by using dependency injection at the time of routing as the following line which is commented in routing "nextViewController.presenterDelegate = LoginViewPresenterImplementation(view: nextViewController)" */
    
    
    @IBAction func signInButtonPressed() {
        guard let vc = LoginViewRouterImplementation.loginVC() else {
            return
        }
        let router = LoginViewRouterImplementation(with: vc)
        vc.presenterDelegate = LoginViewPresenterImplementation(view: vc, router: router)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
