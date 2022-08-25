//
//  FeedbackViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 13/12/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet weak var addFactTextView: UITextView!
    
    var presenter : FeedbackPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "feedback"
        self.presenter = FeedbackPresenter(view: self)
        self.addFactTextView.delegate = self
        self.addFactTextView.text = "enter feedback here!"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitFact(_ sender: UIButton) {
        self.view.endEditing(true)
        if self.addFactTextView.text == "enter feedback here!" {
            self.failure(message: "Please enter feedback first")
            return
        }
        self.presenter.submitFeedback(feedback: self.addFactTextView.text!)
    }
    
}

extension FeedbackViewController : FeedbackPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func feedbackSubmitSuccess() {
        self.addFactTextView.text = "enter feedback here!"
        self.openPopupForSuccess()
    }
    
    private func openPopupForSuccess() {
        let title = "We are bonding!"
        let body = "thank you for your feedback."
        AlertPop.showAlert(alertTitle: title, alertBody: body, leftButtonTitle: "", rightButtonTitle: "okay", isLeftButtonHidden: true, leftButtonCallback: {}, rightButtonCallback: {})
    }
    
}

extension FeedbackViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.addFactTextView.text == "enter feedback here!" {
            self.addFactTextView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text!.isEmpty {
            self.addFactTextView.text = "enter feedback here!"
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
