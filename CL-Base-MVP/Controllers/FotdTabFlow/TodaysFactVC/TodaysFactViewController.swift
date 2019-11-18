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
    
    var presenter : TodaysFactPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TodaysFactPresenter(view: self)
        self.presenter.getTodaysFact()
        // Do any additional setup after loading the view.
    }
    

}

extension TodaysFactViewController : TodaysFactPresenterDelegate {
    
    func failure(message: String) {
         ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func todaysFactSuccess() {
        guard let factModel = self.presenter.factModel, let factData = factModel.fact, let factText =  factData.fact else {
            self.failure(message: "Something went wrong")
            return
        }
        
        UIView.animate(withDuration: 0.5) {
           self.factLabel.text = factText
        }
        self.view.layoutIfNeeded()
    }
    
}
