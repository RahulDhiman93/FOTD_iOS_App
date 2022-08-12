//
//  FactDetailViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 11/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit
import Hippo
import FBAudienceNetwork

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
    @IBOutlet weak var chatButton: UIButton!
    
    var presenter : FactDetailPresenter!
    var tryAdLoadAgain = true
    var multiplier = 1
    var fbInter : FBInterstitialAd!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.addSwipeGestures()
        self.presenter.getFactDetails()
      //  self.setupInter()
        self.setupFBInter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            if SHOW_ADV {
                self?.loadFBInter()
            }
        })
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupView() {
        self.title = "fact details"
        bottomViewHeight.constant = 0
        userImage.isHidden = true
        
        let likeButtonImage = UIImage(named: "likeWhite")?.withRenderingMode(.alwaysTemplate)
        let dislikeButtonImage = UIImage(named: "dislikeWhite")?.withRenderingMode(.alwaysTemplate)
        
        likeButton.setImage(likeButtonImage, for: .normal)
        dislikeButton.setImage(dislikeButtonImage, for: .normal)
        
        chatButton.isHidden = !CHAT_ENABLED
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
        if presenter.currentFactIndex > 0 {
            presenter.currentFactIndex -= 1
            presenter.factId = presenter.totalFactForSwipe[self.presenter.currentFactIndex].factId!
            presenter.getFactDetails()
        }
    }
    
    @objc private func leftSwipe() {
        print("swipeLeft")
        if presenter.currentFactIndex < self.presenter.totalFactForSwipe.count - 1{
            presenter.currentFactIndex += 1
            presenter.factId = presenter.totalFactForSwipe[self.presenter.currentFactIndex].factId!
            presenter.getFactDetails()
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
    
    
    @IBAction func chatButtonTapped(_ sender: UIButton) {
        guard let me = LoginManager.share.me else { return }
        guard let factModel = presenter.factDetailModel, let peerUserId = factModel.addedByUserId, let factId = factModel.factId else {
            self.failure(message: "User not registered for chat yet!")
            return
        }
        guard let peerChatInfo = PeerToPeerChat(uniqueChatId: "\(factId)", myUniqueId: "\(me.userId)", idsOfPeers: ["\(peerUserId)"], channelName: "Fact ID:" + "\(factId)") else { return }
        HippoConfig.shared.showPeerChatWith(data: peerChatInfo, completion: { (success, error) in
            if error != nil {
                self.failure(message: "User not registered for chat yet!")
                return
            }
        })
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

//extension FactDetailViewController {
//
//    private func setupInter() {
//           inter = GADInterstitial(adUnitID: "ca-app-pub-8330967321849957/4669393971")
//           let request = GADRequest()
//           inter.load(request)
//           inter = createAndLoadInterstitial()
//           inter.delegate = self
//       }
//
//       private func createAndLoadInterstitial() -> GADInterstitial {
//           let interstitial = GADInterstitial(adUnitID: "ca-app-pub-8330967321849957/4669393971")
//           interstitial.delegate = self
//           interstitial.load(GADRequest())
//           return interstitial
//       }
//
//       private func loadInt(){
//           if let inter = inter {
//               if inter.isReady {
//                   inter.present(fromRootViewController: self)
//               }
//               else{
//                   let time = Double(2.0) * Double(self.multiplier)
//                   print(time)
//                   DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: { [weak self] in
//                    guard let self = self else { return }
//                       if self.tryAdLoadAgain {
//                           print("TRIED AGAIN")
//                           self.multiplier += 1
//                           if SHOW_ADV {
//                               self.loadInt()
//                           }
//                           if self.multiplier == 3 {
//                               self.tryAdLoadAgain = false
//                           }
//                       }
//                   })
//               }
//           }
//       }
//
//}

//MARK: Facebook interstitial Ad
extension FactDetailViewController : FBInterstitialAdDelegate {
    
    private func setupFBInter() {
        self.fbInter = FBInterstitialAd(placementID: "539268040329220_539270643662293")
        self.fbInter.delegate = self
    }
    
    private func loadFBInter() {
        self.fbInter.load()
    }
    
    func interstitialAdDidLoad(_ interstitialAd: FBInterstitialAd) {
        if interstitialAd.isAdValid {
            interstitialAd.show(fromRootViewController: self)
        } else {
           // self.loadInt()
            print("\nFB not loaded with error ------> NOT A VALID AD")
        }
    }
    
    func interstitialAd(_ interstitialAd: FBInterstitialAd, didFailWithError error: Error) {
        print("\nFB not loaded with error ------> \(error.localizedDescription)")
        print(error)
       // self.loadInt()
    }
}

