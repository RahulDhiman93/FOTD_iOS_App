//
//  SplashViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 21/06/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit
import Hippo
import NotificationBannerSwift
import FirebaseDatabase

class SplashViewController: UIViewController {
    
    var presenter : SplashPresenter!
    var ref: DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        presenter = SplashPresenter(view: self)
        internetConnectivityCheck()
        ref = Database.database().reference()
        ref.child("splashLog").setValue(["Log2" : "Log2"])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func internetConnectivityCheck() {
        if IJReachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            self.checkAppVersion()
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
    
    func checkAppVersion() {
        self.presenter.checkAppVersion()
    }
    
    func accessTokenApiHit() {
        self.presenter.accessTokenApiHit()
    }
    
    

}

extension SplashViewController : SplashPresenterDelegate {
    
    
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func accessTokenApiError(message: String) {
        let alertVc = AlertWithOptionsViewController.loadNibView(alertTitle: "Oops!", alertBody: message, leftButtonTitle: "Log in", rightButtonTitle: "Try again!", isLeftButtonHidden: false)
        
        alertVc.leftButtonCallback(callback: { (_) in
            self.goToLogin()
        })
        
        alertVc.rightButtonCallback(callback: { (_) in
            self.checkAccessToken()
        })
        self.present(alertVc, animated: true, completion: nil)
        return
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
    
    func checkAppVersionSuccess() {
        
        guard let forceUpdateModel = self.presenter.forceUpdateModel else {
            self.checkAccessToken()
            return
        }
        
        guard let isForceUpdate = forceUpdateModel.isForceUpdate else {
            self.checkAccessToken()
            return
        }
        
        if isForceUpdate {
            let alertVc = AlertWithOptionsViewController.loadNibView(alertTitle: "time to update!", alertBody: "we have added a lot of new features for you.\nit's necessary to update the app.", leftButtonTitle: "", rightButtonTitle: "update", isLeftButtonHidden: true)
            
            alertVc.rightButtonCallback(callback: { (_) in
                guard let appLink = forceUpdateModel.appLink else { return }
                guard let url = URL(string: appLink) else { return }
                UIApplication.shared.open(url)
            })
            
            self.present(alertVc, animated: true, completion: nil)
            return
        }
        
        guard let isManualUpdate = forceUpdateModel.isManualUpdate else {
            self.checkAccessToken()
            return
        }
        
        if isManualUpdate {
            let alertVc = AlertWithOptionsViewController.loadNibView(alertTitle: "time to update!", alertBody: "we have added a lot of new features for you.\ndo you want to make them available for your use?", leftButtonTitle: "not now", rightButtonTitle: "update", isLeftButtonHidden: false)
            
            alertVc.leftButtonCallback(callback: { [weak self] (_) in
                self?.checkAccessToken()
            })
            
            alertVc.rightButtonCallback(callback: { (_) in
                guard let appLink = forceUpdateModel.appLink else { return }
                guard let url = URL(string: appLink) else { return }
                UIApplication.shared.open(url)
            })
            
            self.present(alertVc, animated: true, completion: nil)
            return
        }
        
        self.checkAccessToken()
    }
    
}


