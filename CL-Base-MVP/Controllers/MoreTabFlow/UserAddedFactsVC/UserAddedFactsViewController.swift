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
        self.setupTableView()
        self.presenter.getUserFactsForStatus()
    }
    
    private func setupView() {
        self.title = "uploaded facts"
        factTypeSegmentBar.selectedSegmentIndex = presenter.screenType.rawValue
    }
    
    private func setupTableView() {
        self.factsTableView.delegate = self
        self.factsTableView.dataSource = self
        self.factsTableView.bounces = true
        self.factsTableView.separatorStyle = .none
        self.factsTableView.showsVerticalScrollIndicator = false
        self.factsTableView.register(UINib(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularTableViewCell")
    }

    @IBAction func factTypeSegmentChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            presenter.screenType = .approved
        case 1:
            presenter.screenType = .pending
        case 2:
            presenter.screenType = .discarded
        default:
            break
        }
        presenter.getUserFactsForStatus()
    }
    
}

extension UserAddedFactsViewController : UserAddedFactsPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func getUserAddFactsSuccess() {
        factsTableView.reloadData()
        if presenter.facts.count > 0 {
            errorLabel.isHidden = true
            factsTableView.isHidden = false
        } else {
            errorLabel.isHidden = false
            factsTableView.isHidden = true
        }
    }
}

extension UserAddedFactsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  "PopularTableViewCell", for: indexPath) as? PopularTableViewCell else{
            fatalError()
        }
        guard let fact = self.presenter.facts[indexPath.row].fact else { return UITableViewCell() }
        cell.configCell(factText: fact)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard presenter.screenType == .approved else { return }
        guard let vc = FactDetailRouter.FactDetailVC() else { return }
        vc.presenter = FactDetailPresenter(view: vc)
        vc.presenter.factId = self.presenter.facts[indexPath.row].factId
        vc.presenter.currentFactIndex = indexPath.row
        vc.presenter.totalFactForSwipe = self.presenter.facts
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if presenter.facts.count >= 10 {
                self.presenter.skip += 10
                self.presenter.getUserFactsForStatusForPagination()
            }
        }
    }
    
}
