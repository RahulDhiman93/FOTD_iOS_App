//
//  AlertWithOptionsViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 18/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class AlertWithOptionsViewController: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertBody: UILabel!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!

    var alertTitleText = ""
    var alertBodyText = ""
    var leftButtonTitle = ""
    var rightButtonTitle = ""
    var isLeftButtonHidden = false
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()
            + 0.05, execute: {
            self.setupView()
        })
        
        // Do any additional setup after loading the view.
    }
    
    private var leftButtonCallback: ((_ success: Bool) -> Void)?
    private var rightButtonCallback: ((_ success: Bool) -> Void)?
    
    func leftButtonCallback(callback: @escaping ( _ success: Bool) -> Void) {
        self.leftButtonCallback = callback
    }
    
    func rightButtonCallback(callback: @escaping ( _ success: Bool) -> Void) {
        self.rightButtonCallback = callback
    }
    
    
    class func loadNibView(alertTitle : String = "alert", alertBody : String = "" , leftButtonTitle : String = "cancel", rightButtonTitle : String = "okay", isLeftButtonHidden : Bool = false) -> AlertWithOptionsViewController {
        let vc = AlertWithOptionsViewController(nibName: "AlertWithOptionsViewController", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.configAlert(alertTitle: alertTitle, alertBody: alertBody, leftButtonTitle: leftButtonTitle, rightButtonTitle: rightButtonTitle, isLeftButtonHidden: isLeftButtonHidden)
        return vc
    }
    
    func configAlert(alertTitle : String = "alert", alertBody : String , leftButtonTitle : String = "cancel", rightButtonTitle : String = "okay", isLeftButtonHidden : Bool = false) {
        self.alertTitleText = alertTitle
        self.alertBodyText = alertBody
        self.leftButtonTitle = leftButtonTitle
        self.rightButtonTitle = rightButtonTitle
        self.isLeftButtonHidden = isLeftButtonHidden
    }
    
    private func setupView() {
        self.alertTitle.text = self.alertTitleText
        self.alertBody.text = self.alertBodyText
        self.leftButton.setTitle(self.leftButtonTitle, for: .normal)
        self.rightButton.setTitle(self.rightButtonTitle, for: .normal)
        self.leftButton.isHidden = self.isLeftButtonHidden
        self.setAnimations(isContentHidden: false)
    }
    
    private func setAnimations(isContentHidden : Bool) {
        UIView.animate(withDuration: 0.2) {
            self.alertTitle.isHidden = isContentHidden
            self.alertBody.isHidden = isContentHidden
            self.buttonsView.isHidden = isContentHidden
        }
        self.view.layoutIfNeeded()
    }
    
    @IBAction func leftButtonTapped(_ sender: UIButton) {
        self.setAnimations(isContentHidden: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.dismiss(animated: true) {
                self.leftButtonCallback?(true)
            }
        })
       
    }
    
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        self.setAnimations(isContentHidden: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.dismiss(animated: true) {
                self.rightButtonCallback?(true)
            }
        })
    }
    
}
