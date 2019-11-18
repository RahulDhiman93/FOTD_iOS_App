//
//  ErrorView.swift
//  Inforu
//
//  Created by Rahul Dhiman on 21/06/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

protocol ErrorDelegate {
    func removeErrorView()
}

class ErrorView: UIView {

    @IBOutlet weak var statusIcon1: UIImageView!
    @IBOutlet weak var errorMessage1: UILabel!
    @IBOutlet weak var errorButton1: UIButton!
    
    
    var delegate:ErrorDelegate!
    var removingFromSuperView: (() -> Void)?
    var keyboardChange: KeyBoard?
    
    let kHeight: CGFloat = 45.0
    
    
    @IBAction func buttonAction1(_ sender: UIButton) {
        self.hideErrorMessage()
    }
    
    override func awakeFromNib() {
        
        errorMessage1.textColor = UIColor.white
        errorMessage1.font = UIFont.poppinsFontRegular(size: 15)
        
        self.statusIcon1.image = UIImage(named: "Close")!.withRenderingMode(.alwaysTemplate)
        self.statusIcon1.tintColor = UIColor.white
        self.statusIcon1.contentMode = .scaleAspectFit
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideErrorMessage))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        
        keyboardChange = KeyBoard { [weak self] newHeight in
            self?.frame.origin.y = kScreenSize.height - newHeight - (self?.frame.height ?? (self?.kHeight)!)
        }
    }
    
    
    
    func setErrorMessage(message:String, isError:Bool) {
        self.backgroundColor = UIColor.errorColor
        self.errorMessage1.text = message
        let size = message.heightWithConstrainedWidth(width: kScreenSize.width - 57, font: UIFont.poppinsFontRegular(size: 15)!)
        var safeLayoutHeight:CGFloat = 0.0
        if #available(iOS 11.0, *) {
            safeLayoutHeight = self.safeAreaInsets.bottom
        } else {
            safeLayoutHeight = 0.0
            // Fallback on earlier versions
        }
        
        if size.height > 14 {
            self.frame.size.height = (kHeight - 13) + size.height + safeLayoutHeight
        }
        
        self.showErrorMessage()
    }
    
    func showErrorMessage() {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        }, completion: { finished in
            self.perform(#selector(self.hideErrorMessage), with: nil, afterDelay: 2.0)
        })
    }
    
    @objc func hideErrorMessage() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: { [weak self] finished in
            self?.delegate?.removeErrorView()
            self?.removingFromSuperView?()
            self?.removeFromSuperview()
        })
    }
    
    // MARK: - Loading
    static func showWith(message: String, isErrorMessage: Bool = true, removed: (() -> Void)?) {
        let keyWindow = getKeyWindow()
        
        checkAndRemoveErrorViewIfAlreadyPresent()
        
        let errorMessageView = UINib(nibName: "ErrorView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! ErrorView
        errorMessageView.frame = CGRect(x: 0, y: kScreenSize.height, width: kScreenSize.width, height: 45)
        keyWindow?.addSubview(errorMessageView)
        
        errorMessageView.setErrorMessage(message: message,isError: isErrorMessage)
    }
    
    private static func checkAndRemoveErrorViewIfAlreadyPresent() {
        let keyWindow = getKeyWindow()
        
        for tempSubview in keyWindow!.subviews.reversed() {
            if let subView = tempSubview as? ErrorView {
                subView.removeFromSuperview()
                return
            }
        }
        
    }
    
    private static func getKeyWindow() -> UIView? {
        return UIApplication.shared.keyWindow
    }
}

class KeyBoard {
    
    static var height: CGFloat = 0
    static var width: CGFloat = 0
    static var isKeyBoardPresent: Bool {
        return height > 0
    }
    
    var heightChanged: ((CGFloat) -> Void)?
    
    init(heightChanged:  ((CGFloat) -> Void)?) {
        self.heightChanged = heightChanged
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyBoard.keyBoardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyBoard.keyBoardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidChangeHeight(_:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }
    
    @objc private func keyBoardWillShow(_ notification: Notification) {
        setHeightWidthFrom(notification: notification)
    }
    
    @objc private func keyBoardWillHide(_ notification: Notification) {
        //      KeyBoard.height = 0
        //      KeyBoard.width = 0
        //      heightChanged?(0)
    }
    
    @objc private func keyBoardDidChangeHeight(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect, KeyBoard.height != 0 else {
            return
        }
        KeyBoard.height = keyboardFrame.height
        KeyBoard.width = keyboardFrame.width
        heightChanged?(KeyBoard.height)
    }
    
    private func setHeightWidthFrom(notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        KeyBoard.height = keyboardFrame?.height ?? 0
        KeyBoard.width = keyboardFrame?.width ?? 0
        heightChanged?(KeyBoard.height)
    }
    
    
}

