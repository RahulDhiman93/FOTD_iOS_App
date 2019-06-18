//
//  LoginViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 18/06/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logInButtonView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.logInButtonView.clipsToBounds = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        let vc = SignUpViewController.initiate()
        vc.modalTransitionStyle = .partialCurl
        self.present(vc, animated: true, completion: nil)
    }
    
}
