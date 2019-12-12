//
//  SearchFactViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class SearchFactViewController: UIViewController {
    
    
    @IBOutlet weak var searchFactTextField: UITextField!
    @IBOutlet weak var searchFactTableView: UITableView!
    @IBOutlet weak var alertLabel: UILabel!
    
    var presenter : SearchFactPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = SearchFactPresenter(view: self)
        self.searchFactTextField.delegate = self
        self.alertLabel.isHidden = true
        self.setupTableView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.searchFactTextField.becomeFirstResponder()
        })
        // Do any additional setup after loading the view.
    }
    
    private func setupTableView() {
        self.searchFactTableView.delegate = self
        self.searchFactTableView.dataSource = self
        self.searchFactTableView.bounces = true
        self.searchFactTableView.separatorStyle = .none
        self.searchFactTableView.showsVerticalScrollIndicator = false
        self.searchFactTableView.register(UINib(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularTableViewCell")
    }

}

extension SearchFactViewController : SearchFactPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func searchSuccess() {
        self.searchFactTableView.reloadData()
        
        if self.presenter.searchFacts.count < 1 {
            self.searchFactTableView.isHidden = true
            self.alertLabel.isHidden = false
        } else {
            self.searchFactTableView.isHidden = false
            self.alertLabel.isHidden = true
        }
    }
    
}

extension SearchFactViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.searchFacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  "PopularTableViewCell", for: indexPath) as? PopularTableViewCell else{
            fatalError()
        }
        guard let fact = self.presenter.searchFacts[indexPath.row].fact else { return UITableViewCell() }
        cell.configCell(factText: fact)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = FactDetailRouter.FactDetailVC() else { return }
        vc.presenter = FactDetailPresenter(view: vc)
        vc.presenter.factId = self.presenter.searchFacts[indexPath.row].factId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if !self.searchFactTextField.text!.isEmptyOrWhitespace() {
                self.presenter.skip += 5
                self.presenter.searchFact(searchText: self.searchFactTextField.text!)
            }
        }
    }
    
}

extension SearchFactViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if !textField.text!.isEmptyOrWhitespace() {
            self.presenter.skip = 0
            self.presenter.searchFact(searchText: textField.text!)
        } else {
            self.failure(message: "Please type something")
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchFactTextField.resignFirstResponder()
        return true
    }
    
    
}
