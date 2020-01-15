//
//  FactDetailViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 11/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit
import GoogleMobileAds

class FactDetailViewController: UIViewController , GADInterstitialDelegate{
    
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
    var inter:GADInterstitial!
    var tryAdLoadAgain = true
    var multiplier = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.addSwipeGestures()
        self.presenter.getFactDetails()
        self.setupInter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            self?.loadInt()
        })
        // Do any additional setup after loading the view.
    }
    
    
    private func setupView() {
        self.title = "fact details"
        self.bottomViewHeight.constant = 0
        self.userImage.isHidden = true
        
        let likeButtonImage = UIImage(named: "likeWhite")?.withRenderingMode(.alwaysTemplate)
        let dislikeButtonImage = UIImage(named: "dislikeWhite")?.withRenderingMode(.alwaysTemplate)
        
        self.likeButton.setImage(likeButtonImage, for: .normal)
        self.dislikeButton.setImage(dislikeButtonImage, for: .normal)
    }
    
    private func addSwipeGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.rightSwipe))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.leftSwipe))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc private func rightSwipe() {
        print("swipeRight")
        if self.presenter.currentFactIndex > 0 {
            self.presenter.currentFactIndex -= 1
            self.presenter.factId = self.presenter.totalFactForSwipe[self.presenter.currentFactIndex].factId!
            self.presenter.getFactDetails()
        }
    }
    
    @objc private func leftSwipe() {
        print("swipeLeft")
        if self.presenter.currentFactIndex < self.presenter.totalFactForSwipe.count - 1{
            self.presenter.currentFactIndex += 1
            self.presenter.factId = self.presenter.totalFactForSwipe[self.presenter.currentFactIndex].factId!
            self.presenter.getFactDetails()
        }
    }
    
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        guard let factModel = self.presenter.factDetailModel, factModel.userLikeStatus == 2 || factModel.userLikeStatus == 0 else {
            self.presenter.factDetailModel!.likeCount! -= 1
            self.presenter.factDetailModel!.userLikeStatus! = 2
            self.fetchDetailSuccess()
            self.presenter.likeFact(status: 2)
            return
        }
        self.presenter.factDetailModel!.likeCount! += 1
        if self.presenter.factDetailModel!.userLikeStatus! == 0 {
            self.presenter.factDetailModel!.dislikeCount! -= 1
        }
        self.presenter.factDetailModel!.userLikeStatus! = 1
        self.fetchDetailSuccess()
        self.presenter.likeFact(status: 1)
    }
    
    @IBAction func dislikeButtonTapped(_ sender: UIButton) {
        guard let factModel = self.presenter.factDetailModel, factModel.userLikeStatus == 2 || factModel.userLikeStatus == 1 else {
            self.presenter.factDetailModel!.dislikeCount! -= 1
            self.presenter.factDetailModel!.userLikeStatus! = 2
            self.fetchDetailSuccess()
            self.presenter.likeFact(status: 2)
            return
        }
        self.presenter.factDetailModel!.dislikeCount! += 1
        if self.presenter.factDetailModel!.userLikeStatus! == 1 {
            self.presenter.factDetailModel!.likeCount! -= 1
        }
        self.presenter.factDetailModel!.userLikeStatus! = 0
        self.fetchDetailSuccess()
        self.presenter.likeFact(status: 0)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let factModel = self.presenter.factDetailModel, let fact = factModel.fact else { return }
        AppUsables.shareFact(fact: fact)
    }
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        guard let factModel = self.presenter.factDetailModel, factModel.userFavStatus == 0 else {
            self.presenter.factDetailModel!.userFavStatus! = 0
            self.fetchDetailSuccess()
            self.presenter.addFactFav(status: 0)
            return
        }
        self.presenter.factDetailModel!.userFavStatus! = 1
        self.fetchDetailSuccess()
        self.presenter.addFactFav(status: 1)
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
            self.factLabel.text = factModel.fact!
        })
        
        UIView.transition(with: userName, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.userName.text = factModel.addedBy!
        })
        
        UIView.transition(with: timeAgoForFact, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.timeAgoForFact.text = "posted on " + self.presenter.beautifyPostedDate(date: factModel.addedOn!)
        })
        
        UIView.transition(with: userImage, duration: 1.0, options: .transitionCrossDissolve, animations: {
           self.userImage.kf.setImage(with: URL(string: factModel.userImage!), placeholder: UIImage(named: "placeholder"))
            self.userImage.isHidden = false
        })
        
        
        UIView.transition(with: likeCount, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.likeCount.text = "\(factModel.likeCount!)"
        })
        
        UIView.transition(with: dislikeCount, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.dislikeCount.text = "\(factModel.dislikeCount!)"
        })
        
        UIView.transition(with: likeButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
            if factModel.userLikeStatus! == 1 {
                self.likeButton.tintColor = AppColor.themeSecondaryColor
                self.likeCount.textColor = AppColor.themeSecondaryColor
            } else {
                self.likeButton.tintColor = .white
                self.likeCount.textColor = .white
            }
        })
        
        UIView.transition(with: dislikeButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
            if factModel.userLikeStatus! == 0 {
                self.dislikeButton.tintColor = AppColor.themeSecondaryColor
                self.dislikeCount.textColor = AppColor.themeSecondaryColor
            } else {
                self.dislikeButton.tintColor = .white
                self.dislikeCount.textColor = .white
            }
        })
        
        UIView.transition(with: favButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
            if factModel.userFavStatus! == 1 {
                self.favButton.setImage(UIImage(named: "heartFilled"), for: .normal)
            } else {
                self.favButton.setImage(UIImage(named: "heartWhite"), for: .normal)
            }
        })
        
        if !UserDefaults.standard.bool(forKey: "showTut") {
            self.showTut()
            UserDefaults.standard.set(true, forKey: "showTut")
        }
       
    }
    
    private func showTut() {
        let vc = TutorialForSwipeViewController(nibName: "TutorialForSwipeViewController", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension FactDetailViewController {
    
    private func setupInter() {
           inter = GADInterstitial(adUnitID: "ca-app-pub-8330967321849957/2163363210")
           let request = GADRequest()
           inter.load(request)
           inter = createAndLoadInterstitial()
           inter.delegate = self
       }
       
       private func createAndLoadInterstitial() -> GADInterstitial {
           let interstitial = GADInterstitial(adUnitID: "ca-app-pub-8330967321849957/2163363210")
           interstitial.delegate = self
           interstitial.load(GADRequest())
           return interstitial
       }
       
       private func loadInt(){
           if let inter = inter {
               if inter.isReady {
                   inter.present(fromRootViewController: self)
               }
               else{
                   let time = Double(2.0) * Double(self.multiplier)
                   print(time)
                   DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: { [weak self] in
                    guard let self = self else { return }
                       if self.tryAdLoadAgain {
                           print("TRIED AGAIN")
                           self.multiplier += 1
                           self.loadInt()
                           if self.multiplier == 3 {
                               self.tryAdLoadAgain = false
                           }
                       }
                   })
               }
           }
       }
    
}
