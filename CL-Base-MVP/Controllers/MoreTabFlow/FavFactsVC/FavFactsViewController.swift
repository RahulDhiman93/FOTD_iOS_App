//
//  FavFactsViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class FavFactsViewController: UIViewController {

    @IBOutlet weak var favFactsTableView: UITableView!
    @IBOutlet weak var alertLabel: UILabel!
    
    var presenter : FavFactsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = FavFactsPresenter(view: self)
        self.title = "favourite facts"
        self.alertLabel.isHidden = true
        self.setupTableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.getFavFacts()
    }

    private func setupTableView() {
        self.favFactsTableView.delegate = self
        self.favFactsTableView.dataSource = self
        self.favFactsTableView.bounces = true
        self.favFactsTableView.separatorStyle = .none
        self.favFactsTableView.showsVerticalScrollIndicator = false
        self.favFactsTableView.register(UINib(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularTableViewCell")

    }

}

extension FavFactsViewController : FavFactsPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }

    func fetchFavFactsSuccess() {
        self.favFactsTableView.reloadData()
        if self.presenter.favFacts.count > 0 {
            self.favFactsTableView.isHidden = false
            self.alertLabel.isHidden = true
        } else {
            self.favFactsTableView.isHidden = true
            self.alertLabel.isHidden = false
        }
    }
}

extension FavFactsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.favFacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  "PopularTableViewCell", for: indexPath) as? PopularTableViewCell else{
            fatalError()
        }
        guard let fact = self.presenter.favFacts[indexPath.row].fact else { return UITableViewCell() }
        cell.configCell(factText: fact)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = FactDetailRouter.FactDetailVC() else { return }
        vc.presenter = FactDetailPresenter(view: vc)
        vc.presenter.factId = self.presenter.favFacts[indexPath.row].factId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.presenter.removeFactFav(factId: self.presenter.favFacts[indexPath.row].factId)
            self.presenter.favFacts.remove(at: indexPath.row)
            self.favFactsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            self.presenter.limit += 10
            self.presenter.getFavFacts()
        }
    }
    
}
