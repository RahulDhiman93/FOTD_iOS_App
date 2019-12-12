//
//  MoreViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    @IBOutlet weak var moreTableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    
    var presenter : MorePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MorePresenter(view : self)
        self.setupView()
        self.setupTableView()
        // Do any additional setup after loading the view.
    }

    private func setupView() {
        self.versionLabel.text = "v" + Config.sharedInstance.appVersion()
    }
    
    private func setupTableView() {
        self.moreTableView.delegate = self
        self.moreTableView.dataSource = self
        self.moreTableView.bounces = false
        self.moreTableView.separatorStyle = .none
        self.moreTableView.showsVerticalScrollIndicator = false
        self.moreTableView.register(UINib(nibName: "MoreRowsTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreRowsTableViewCell")
    }
    
    private func logout() {
        AlertPop.showAlert(alertTitle: "logging out?", alertBody: "are you sure you want to logout?", leftButtonTitle: "yes, logout", rightButtonTitle: "cancel", isLeftButtonHidden: false, leftButtonCallback: {
            self.presenter.logoutCall()
        }, rightButtonCallback: {
            //Nothing happens here
        })
    }
    
    private func goToInsta() {
        let Username =  AppConstants.instgramLink
        let appURL = URL(string: "instagram://user?username=\(Username)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                application.open(appURL)
            } else {
                application.openURL(appURL)
            }
        } else {
            // if Instagram app is not installed, open URL inside Safari
            let webURL = URL(string: "https://instagram.com/\(Username)")!
            if #available(iOS 10.0, *) {
                application.open(webURL)
            } else {
                application.openURL(webURL)
            }
        }
    }
    
    private func aboutUs() {
        let vc = AboutUsViewController(nibName: "AboutUsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func goToProfile() {
        guard let vc = ProfileRouter.ProfileVC() else { fatalError() }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func goToFavFacts() {
        guard let vc = FavFactsRouter.FavFactsVC() else { fatalError() }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func goToFeedback() {
        guard let vc = FeedbackRouter.FeedbackVC() else { fatalError() }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MoreViewController : MorePresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func logoutSuccess() {
        guard let vc = LoginRouter.LoginVC() else {
            return
        }
        let navigationController = UINavigationController()
        navigationController.viewControllers = [vc]
        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            appDelegate.window?.rootViewController = navigationController
        }, completion: nil)
    }

}

extension MoreViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  "MoreRowsTableViewCell", for: indexPath) as? MoreRowsTableViewCell else{
            fatalError()
        }
        
        switch numberOfMoreVcRows(rawValue : indexPath.row)! {
        case .profile:
            cell.configCell(image: "userPurple", name: "profile")
        case .favourites:
            cell.configCell(image: "favourites", name: "favourites")
        case .instagram:
            cell.configCell(image: "instagram", name: "follow us on Instagram")
        case .feedback:
            cell.configCell(image: "feedback", name: "feedback")
        case .aboutUs:
            cell.configCell(image: "aboutUs", name: "about us")
        case .logout:
            cell.configCell(image: "logout", name: "logout")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch numberOfMoreVcRows(rawValue : indexPath.row)! {
        case .profile:
            self.goToProfile()
        case .favourites:
            self.goToFavFacts()
        case .instagram:
            self.goToInsta()
        case .feedback:
            self.goToFeedback()
        case .aboutUs:
            self.aboutUs()
        case .logout:
            self.logout()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
}

