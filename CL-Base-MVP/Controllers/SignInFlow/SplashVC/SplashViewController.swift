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
        self.progressHUD.isHidden = true
        self.presenter = SplashPresenter(view: self)
        self.internetConnectivityCheck()
        // Do any additional setup after loading the view.
    }
    
    func internetConnectivityCheck() {
        
        if IJReachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            // self.versionCheck()
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
            let alertVc = AlertWithOptionsViewController.loadNibView(alertTitle: "time to update!", alertBody: "we have added a lot of new features for you.\nIt's necessary to update the app.", leftButtonTitle: "", rightButtonTitle: "update", isLeftButtonHidden: true)
            
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
            let alertVc = AlertWithOptionsViewController.loadNibView(alertTitle: "time to update!", alertBody: "we have added a lot of new features for you.\nDo you want to make them available for your use?", leftButtonTitle: "not now", rightButtonTitle: "update", isLeftButtonHidden: false)
            
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
