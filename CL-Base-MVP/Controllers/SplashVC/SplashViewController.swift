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
    
    var presenter : SplashPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.presenter = SplashPresenter(view: self)
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
            self.goToLogin()
        }
    }
    
    func accessTokenApiHit() {
        self.progressHUD.isHidden = true
        self.presenter.accessTokenApiHit()
    }


}

extension SplashViewController : SplashPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func accessTokenVerified() {
        let sb = UIStoryboard(name: "Home", bundle: nil)
         guard let vc = sb.instantiateViewController(withIdentifier: "AppBaseViewController") as? AppBaseViewController else { fatalError("TabBar Instance failed") }
        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
             appDelegate.window?.rootViewController = vc
         }, completion: nil)
    }
    
    func goToLogin() {
        guard let vc = LoginRouter.LoginVC() else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
