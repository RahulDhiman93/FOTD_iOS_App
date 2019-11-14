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
            
            guard response != nil, error == nil else {
                ErrorView.showWith(message: error?.localizedDescription ?? "Server Error, Please try again!", isErrorMessage: true) {
                }
                let vc = LoginViewController.initiate()
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }
            
            let sb = UIStoryboard(name: "Home", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "AppBaseViewController") as? AppBaseViewController else { fatalError("TabBar Instance failed") }
            self.navigationController?.pushViewController(vc, animated: true)
          
            
        })
    }


}
