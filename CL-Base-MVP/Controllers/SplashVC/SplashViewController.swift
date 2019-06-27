//
//  SplashViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 21/06/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var progressHUD: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.internetConnectivityCheck()
        // Do any additional setup after loading the view.
    }
    
    func internetConnectivityCheck() {
        if IJReachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            // self.versionCheck()
            self.checkAccessToken()
        } else {
            print("Internet connection FAILED")
            ErrorView.showWith(message: "No Internet Connection Found, Try Again!", isErrorMessage: true ){
                self.internetConnectivityCheck()
            }
        }
    }
    
    func checkAccessToken() {
        if LoginManager.share.isAccessTokenValid {
            self.accessTokenApiHit()
        } else {
            let vc = LoginViewController.initiate()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func accessTokenApiHit() {
        
        LoginManager.share.loginFromAccessToken(callback: { response , error in
            
            self.progressHUD.isHidden = true
            
            if error != nil {
                ErrorView.showWith(message: error?.localizedDescription ?? "Server Error, Please try again!", isErrorMessage: true) {
                }
                let vc = LoginViewController.initiate()
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }
            
            if response != nil {
                let vc = HomeViewController.initiate()
                self.navigationController?.pushViewController(vc, animated: true)
            }
                
            else {
                ErrorView.showWith(message: "Server Error, Please try again!", isErrorMessage: true) {
                }
                let vc = LoginViewController.initiate()
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }
            
        })
    }


}
