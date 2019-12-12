//
//  FeedbackViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 13/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    var presenter : FeedbackPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "feedback"
        self.presenter = FeedbackPresenter(view: self)
        
        // Do any additional setup after loading the view.
    }
    
}

extension FeedbackViewController : FeedbackPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
}
