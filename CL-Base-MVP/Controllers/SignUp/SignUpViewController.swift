//
//  SignUpViewController.swift
//  CL-Base-MVP
//
//  Created by Deepak Sharma on 11/28/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
     var presenterDelegate: SignUpPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.delegateSetup()
        self.addTopSpace()
        self.registerCell()
        self.tableSetup()
    }

//    //Delegate setup without dependency injection
//    private func delegateSetup() {
//        self.presenterDelegate = SignUpViewPresenterImplementation(view: self)
//    }
//
    //Setup Tableview
    private func tableSetup() {
        tblView.delegate = self
        tblView.dataSource = self
       // tblView.hideLastCellLine()
        tblView.rowHeight = UITableViewAutomaticDimension
        tblView.estimatedRowHeight = 60
    }
    
    //Add Tableview TopSpace
    private func addTopSpace() {
        let topInset = 30
        tblView.contentInset =  UIEdgeInsetsMake(CGFloat(topInset), 0, 0, 0)
    }
    
    //Register Custom Tableview cells:
    private func registerCell() {
        tblView.registerCell(InputTextFieldCell.cellIdentifier())
        tblView.registerCell(SignupButtonCell.cellIdentifier())
    }
    
    func signUPButtonPressed() {
        if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    func signInButtonPressed() {
        if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
}

extension SignUpViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenterDelegate.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellDataModel = presenterDelegate.viewModel(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellDataModel.identifier) else {
            fatalError()
        }
        if let cell = cell as? InputTextFieldCell, let viewModel = cellDataModel as? DataTextModel {
            cell.delegate = self
            cell.setupView(viewModel: viewModel)
        }
        
        if let cell = cell as? SignupButtonCell {
            cell.delegate = self
        }
        
        return cell
    }
}
extension SignUpViewController: SignupView {
    func reloadTableView() {
        self.tblView.reloadData()
    }
    
    func reload(at index: [IndexPath]) {
        self.tblView.reloadRows(at: index, with: .fade)
    }
    
    func showError(message: String) {
        UIAlertController.presentAlert(title: "", message: message, style: UIAlertControllerStyle.alert).action(title: "Ok".localized, style: UIAlertActionStyle.default) { (action: UIAlertAction) in
        }
    }
    
    
    func showForgotPasswordMessage(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes".localized, style: .default) { (_) in
            
        }
        let no = UIAlertAction(title: "No".localized, style: .cancel) { (_) in
            
        }
        alert.addAction(no)
        alert.addAction(yesAction)
    }
}

extension SignUpViewController: InputTextFieldCellDelegate {
    func shouldChange(text: String, string: String, cell: UITableViewCell) -> Bool {
        guard let index = self.tblView.indexPath(for: cell) else {
            return false
        }
        return presenterDelegate.shouldChange(text: text, string: string, index: index)
    }
    func buttonTapped(call cell: UITableViewCell) {
        guard let index = self.tblView.indexPath(for: cell) else {
            return
        }
        return presenterDelegate.infoTapped(at: index)
    }
}

extension SignUpViewController: SignupButtonCellDelegate {
    func buttonTapped(on cell: UITableViewCell) {
        presenterDelegate.signupTapped()
    }
}
