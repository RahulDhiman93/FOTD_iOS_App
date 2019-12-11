//
//  FactDetailViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 11/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class FactDetailViewController: UIViewController {
    
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeAgoForFact: UILabel!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var dislikeCount: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    
    
    var presenter : FactDetailPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "fact details"
        self.bottomViewHeight.constant = 0
        self.userImage.isHidden = true
        self.presenter.getFactDetails()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func dislikeButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
    }
    
    
}

extension FactDetailViewController : FactDetailPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func fetchDetailSuccess() {
        
        guard let factModel = self.presenter.factDetailModel else {
            self.failure(message: "Something went wrong")
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.bottomViewHeight.constant = 200
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
        UIView.transition(with: factLabel, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.factLabel.text = factModel.fact!.lowercased()
        })
        
        UIView.transition(with: userName, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.userName.text = factModel.addedBy!.lowercased()
        })
        
        UIView.transition(with: timeAgoForFact, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.timeAgoForFact.text = "posted on: " + self.presenter.beautifyPostedDate(date: factModel.addedOn!)
        })
        
        UIView.transition(with: userImage, duration: 1.0, options: .transitionCrossDissolve, animations: {
           self.userImage.kf.setImage(with: URL(string: factModel.userImage!), placeholder: UIImage(named: "placeholder"))
            self.userImage.isHidden = false
        })
        
        
        UIView.transition(with: likeCount, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.likeCount.text = "\(factModel.likeCount!)"
        })
        
        UIView.transition(with: dislikeCount, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.dislikeCount.text = "\(factModel.dislikeCount!)"
        })
        
    }
    
}
