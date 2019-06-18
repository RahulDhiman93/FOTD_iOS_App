//
//  SignUpViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 18/06/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    class func initiate() -> SignUpViewController {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        return controller
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
