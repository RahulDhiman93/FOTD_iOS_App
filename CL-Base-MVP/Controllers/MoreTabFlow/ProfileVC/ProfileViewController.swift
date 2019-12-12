//
//  ProfileViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var approvedFacts: UILabel!
    @IBOutlet weak var pendingFacts: UILabel!
    @IBOutlet weak var discardedFacts: UILabel!
    
    var presenter : ProfilePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ProfilePresenter(view: self)
        self.setupView()
        self.presenter.getProfileData()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        
        self.title = "profile"
        
        guard let me = LoginManager.share.me else {
            self.failure(message: "Something went wrong")
            self.navigationController?.popViewController(animated: true)
            return
        }
        self.profileImageView.kf.setImage(with: URL(string: me.profileImage), placeholder: UIImage(named: "placeholder"))
        self.userName.text = me.userName
        self.userEmail.text = me.email
        self.approvedFacts.text = "\(me.approvedCount)"
        self.pendingFacts.text = "\(me.pendingCount)"
        self.discardedFacts.text = "\(me.rejectedCount)"
    }
    
}

extension ProfileViewController : ProfilePresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func fetchProfileSuccess() {
        
        guard let me = LoginManager.share.me else {
            self.failure(message: "Something went wrong")
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        self.profileImageView.kf.setImage(with: URL(string: me.profileImage), placeholder: UIImage(named: "placeholder"))
        
        UIView.transition(with: userName, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.userName.text = me.userName
        })
        
        UIView.transition(with: userEmail, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.userEmail.text = me.email
        })
        
        UIView.transition(with: approvedFacts, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.approvedFacts.text = "\(me.approvedCount)"
        })
        
        UIView.transition(with: pendingFacts, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.pendingFacts.text = "\(me.pendingCount)"
        })
        
        UIView.transition(with: discardedFacts, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.discardedFacts.text = "\(me.rejectedCount)"
        })
        
    }
}
