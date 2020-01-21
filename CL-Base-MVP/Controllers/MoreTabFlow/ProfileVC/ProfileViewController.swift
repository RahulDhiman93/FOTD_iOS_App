//
//  ProfileViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var approvedFacts: UILabel!
    @IBOutlet weak var pendingFacts: UILabel!
    @IBOutlet weak var discardedFacts: UILabel!
    
    var presenter : ProfilePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ProfilePresenter(view: self)
        self.setupView()
        self.presenter.getProfileData()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        
        self.title = "profile"
        
        guard let me = LoginManager.share.me else {
            self.failure(message: "Something went wrong")
            self.navigationController?.popViewController(animated: true)
            return
        }
        self.profileImageView.kf.setImage(with: URL(string: me.profileImage), placeholder: UIImage(named: "placeholder"))
        self.userName.text = me.userName
        self.userEmail.text = me.email
        self.approvedFacts.text = "\(me.approvedCount)"
        self.pendingFacts.text = "\(me.pendingCount)"
        self.discardedFacts.text = "\(me.rejectedCount)"
    }
    
    @IBAction func changeProfilePicTapped(_ sender: UIButton) {
        self.changeProfilePic()
    }
    
    @IBAction func changePasswordTapped(_ sender: UIButton) {
        self.openPopupForOTP()
    }
    
    private func openPopupForOTP() {
        let title = "OTP verification required"
        let body = "please check for OTP in your registered email inbox"
        AlertPop.showAlert(alertTitle: title, alertBody: body, leftButtonTitle: "cancel", rightButtonTitle: "okay", isLeftButtonHidden: false, leftButtonCallback: {}, rightButtonCallback: {
            self.presenter.sendForgotPasswordEmail()
        })
    }
}

extension ProfileViewController : ProfilePresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func fetchProfileSuccess() {
        
        guard let me = LoginManager.share.me else {
            self.failure(message: "Something went wrong")
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        self.profileImageView.kf.setImage(with: URL(string: me.profileImage), placeholder: UIImage(named: "placeholder"))
        
        UIView.transition(with: userName, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.userName.text = me.userName
        })
        
        UIView.transition(with: userEmail, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.userEmail.text = me.email
        })
        
        UIView.transition(with: approvedFacts, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.approvedFacts.text = "\(me.approvedCount)"
        })
        
        UIView.transition(with: pendingFacts, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.pendingFacts.text = "\(me.pendingCount)"
        })
        
        UIView.transition(with: discardedFacts, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.discardedFacts.text = "\(me.rejectedCount)"
        })
        
    }
    
    func emailSuccess() {
        guard let me = LoginManager.share.me else { return }
        guard let vc = OtpVerificationRouter.OtpVerificationVC() else { fatalError() }
        vc.presenter = OtpVerificationPresenter(view: vc)
        vc.presenter.email = me.email
        vc.presenter.isComingFromMoreTab = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func changeProfilePic() {
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: nil , message: "Please Select Source", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let cameraActionButton = UIAlertAction(title: "Camera", style: .default)
        { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.pickIT(.camera)
            }
            else{
                self.failure(message: "Camera not available")
            }
        }
        actionSheetControllerIOS8.addAction(cameraActionButton)
        
        let galleryActionButton = UIAlertAction(title: "Photo Gallery", style: .default)
        { _ in
            self.pickIT(.photoLibrary)
        }
        actionSheetControllerIOS8.addAction(galleryActionButton)
        
        if let popoverController = actionSheetControllerIOS8.popoverPresentationController {
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.sourceView = self.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    func pickIT(_ source: UIImagePickerController.SourceType){
        
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = source
        if source == .camera{
            pickController.cameraCaptureMode = .photo
            pickController.modalPresentationStyle = .fullScreen }
        pickController.allowsEditing = true
        self.present(pickController, animated: true,completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageUrl = info[.imageURL] as? NSURL, let pathExt = imageUrl.pathExtension, pathExt == "gif"  {
            dismiss(animated: true){
                self.failure(message: "Not an image")
            }
            return
        }
        
        if let image = info[.editedImage] as? UIImage {
            self.presenter.addProfileImage(profileImage: image)
        } else if let image = info[.originalImage] as? UIImage {
            self.presenter.addProfileImage(profileImage: image)
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
