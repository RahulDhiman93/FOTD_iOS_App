//
//  AddFactViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 27/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class AddFactViewController: UIViewController {
    
    @IBOutlet weak var addFactTextView: UITextView!
    
    var presenter : AddFactPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = AddFactPresenter(view: self)
        self.addFactTextView.text = "enter fact here!"
        self.addFactTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.presenter.addFact()
    }
    
}

extension AddFactViewController : AddFactPresenterDelegate {
    
    func failure(message: String) {
         ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func addSuccess() {
        self.addFactTextView.text = "enter fact here!"
        self.presenter.factText = nil
        self.openPopupForSuccess()
    }
    
    private func openPopupForSuccess() {
        let title = "thank you!"
        let body = "how we accept your fact?\n\n1. we will look into the fact in 24 hours.\n2. check back in a day or two in blogs or simply search it!."
        AlertPop.showAlert(alertTitle: title, alertBody: body, leftButtonTitle: "", rightButtonTitle: "okay", isLeftButtonHidden: true, leftButtonCallback: {}, rightButtonCallback: {})
    }
}

extension AddFactViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.addFactTextView.text == "enter fact here!" {
            self.addFactTextView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text!.isEmpty {
           self.addFactTextView.text = "enter fact here!"
        } else {
            self.presenter.factText = textView.text
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}
