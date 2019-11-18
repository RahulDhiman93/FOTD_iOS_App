//
//  HomeViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 28/06/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.showAlert()
        })
        
    }
    
    private func showAlert() {
        let alertVc = AlertWithOptionsViewController.loadNibView(alertTitle: "Thank you!", alertBody: "Thank you for installing our app.\nThanks again", leftButtonTitle: "okayqq", rightButtonTitle: "yayaya", isLeftButtonHidden: true)
        self.present(alertVc, animated: true, completion: nil)
    }
    
}
