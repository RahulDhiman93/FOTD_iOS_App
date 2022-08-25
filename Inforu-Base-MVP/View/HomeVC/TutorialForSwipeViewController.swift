//
//  TutorialForSwipeViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 23/12/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit

class TutorialForSwipeViewController: UIViewController {

    @IBOutlet weak var centerImageYConst: NSLayoutConstraint!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.playAnimation()
        })
        
        // Do any additional setup after loading the view.
    }

    private func playAnimation() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.centerImageYConst.constant = 40
            self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.centerImageYConst.constant = -50
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.playAnimation()
            })
        })
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
