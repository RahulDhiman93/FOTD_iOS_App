//
//  UserAddedFactsViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 22/01/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class UserAddedFactsViewController: UIViewController {
    
    @IBOutlet weak var factTypeSegmentBar: UISegmentedControl!
    @IBOutlet weak var factsTableView: UITableView!
    @IBOutlet weak var errorLabel: UITableView!
    
    var presenter : UserAddedFactsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.title = "uploaded facts"
        factTypeSegmentBar.selectedSegmentIndex = presenter.screenType.rawValue
    }

    @IBAction func factTypeSegmentChange(_ sender: UISegmentedControl) {
    }
    
}

extension UserAddedFactsViewController : UserAddedFactsPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
}
