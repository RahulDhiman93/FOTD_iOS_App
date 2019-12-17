//
//  TodaysFactViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 18/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class TodaysFactViewController: UIViewController {
    
    @IBOutlet weak var factLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var dislikeCount: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var presenter : TodaysFactPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TodaysFactPresenter(view: self)
        self.setupView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.getTodaysFact()
    }
    
    private func setupView() {
        let likeButtonImage = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        let dislikeButtonImage = UIImage(named: "dislike")?.withRenderingMode(.alwaysTemplate)
        
        
        self.likeButton.setImage(likeButtonImage, for: .normal)
        self.dislikeButton.setImage(dislikeButtonImage, for: .normal)
        
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                // User Interface is Dark
                self.likeButton.tintColor = .white
                self.likeCount.textColor = .white
                self.dislikeButton.tintColor = .white
                self.dislikeCount.textColor = .white
            } else {
                self.likeButton.tintColor = .black
                self.likeCount.textColor = .black
                self.dislikeButton.tintColor = .black
                self.dislikeCount.textColor = .black
                // User Interface is Light
            }
        } else {
            // Fallback on earlier versions
            self.likeButton.tintColor = .black
            self.likeCount.textColor = .black
            self.dislikeButton.tintColor = .black
            self.dislikeCount.textColor = .black
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        guard let factModel = self.presenter.factModel, factModel.userLikeStatus == 2 || factModel.userLikeStatus == 0 else {
            self.presenter.factModel!.likeCount! -= 1
            self.presenter.factModel!.userLikeStatus! = 2
            self.todaysFactSuccess()
            self.presenter.likeFact(status: 2)
            return
        }
        self.presenter.factModel!.likeCount! += 1
        if self.presenter.factModel!.userLikeStatus! == 0 {
            self.presenter.factModel!.dislikeCount! -= 1
        }
        self.presenter.factModel!.userLikeStatus! = 1
        self.todaysFactSuccess()
        self.presenter.likeFact(status: 1)
    }
    
    @IBAction func dislikeButtonTapped(_ sender: UIButton) {
        guard let factModel = self.presenter.factModel, factModel.userLikeStatus == 2 || factModel.userLikeStatus == 1 else {
            self.presenter.factModel!.dislikeCount! -= 1
            self.presenter.factModel!.userLikeStatus! = 2
            self.todaysFactSuccess()
            self.presenter.likeFact(status: 2)
            return
        }
        self.presenter.factModel!.dislikeCount! += 1
        if self.presenter.factModel!.userLikeStatus! == 1 {
            self.presenter.factModel!.likeCount! -= 1
        }
        self.presenter.factModel!.userLikeStatus! = 0
        self.todaysFactSuccess()
        self.presenter.likeFact(status: 0)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let factModel = self.presenter.factModel,  let factData = factModel.fact, let factText =  factData.fact else { return }
        AppUsables.shareFact(fact: factText)
    }
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        guard let factModel = self.presenter.factModel, factModel.userFavStatus == 0 else {
            self.presenter.factModel!.userFavStatus! = 0
            self.todaysFactSuccess()
            self.presenter.addFactFav(status: 0)
            return
        }
        self.presenter.factModel!.userFavStatus! = 1
        self.todaysFactSuccess()
        self.presenter.addFactFav(status: 1)
    }
}

extension TodaysFactViewController : TodaysFactPresenterDelegate {
    
    func failure(message: String) {
         ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func todaysFactSuccess() {
        guard let factModel = self.presenter.factModel, let factData = factModel.fact, let factText =  factData.fact else {
            self.failure(message: "something went wrong")
            return
        }
        
        UIView.animate(withDuration: 0.5) {
           self.factLabel.text = factText
        }
        self.view.layoutIfNeeded()
        
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
                
                if #available(iOS 12.0, *) {
                    if self.traitCollection.userInterfaceStyle == .dark {
                        // User Interface is Dark
                        self.likeButton.tintColor = .white
                        self.likeCount.textColor = .white
                    } else {
                        self.likeButton.tintColor = .black
                        self.likeCount.textColor = .black
                        // User Interface is Light
                    }
                } else {
                    // Fallback on earlier versions
                    self.likeButton.tintColor = .black
                    self.likeCount.textColor = .black
                }
                
                
            }
        })
        
        UIView.transition(with: dislikeButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
            if factModel.userLikeStatus! == 0 {
                self.dislikeButton.tintColor = AppColor.themeSecondaryColor
                self.dislikeCount.textColor = AppColor.themeSecondaryColor
            } else {
                if #available(iOS 12.0, *) {
                    if self.traitCollection.userInterfaceStyle == .dark {
                        // User Interface is Dark
                        self.dislikeButton.tintColor = .white
                        self.dislikeCount.textColor = .white
                    } else {
                        self.dislikeButton.tintColor = .black
                        self.dislikeCount.textColor = .black
                        // User Interface is Light
                    }
                } else {
                    // Fallback on earlier versions
                    self.dislikeButton.tintColor = .black
                    self.dislikeCount.textColor = .black
                }
            }
        })
        
        UIView.transition(with: favButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
            if factModel.userFavStatus! == 1 {
                self.favButton.setImage(UIImage(named: "heartFilled"), for: .normal)
            } else {
                self.favButton.setImage(UIImage(named: "heart"), for: .normal)
            }
        })
    }
    
}
