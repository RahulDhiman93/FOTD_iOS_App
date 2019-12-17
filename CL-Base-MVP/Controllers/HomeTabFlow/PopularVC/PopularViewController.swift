//
//  PopularViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 16/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController {
    
    @IBOutlet weak var alertLabel : UILabel!
    @IBOutlet weak var popularTableView : UITableView!
    
    var presenter : PopularPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "popular"
        self.presenter = PopularPresenter(view: self)
        self.setupTableView()
        self.alertLabel.isHidden = true
        self.popularTableView.isHidden = true
        self.presenter.getPopularFact()
        // Do any additional setup after loading the view.
    }

    private func setupTableView() {
        self.popularTableView.delegate = self
        self.popularTableView.dataSource = self
        self.popularTableView.bounces = true
        self.popularTableView.separatorStyle = .none
        self.popularTableView.showsVerticalScrollIndicator = false
        self.popularTableView.register(UINib(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularTableViewCell")
    }
}

extension PopularViewController : PopularPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func fetchPopularSuccess() {
        self.popularTableView.reloadData()
        
        if self.presenter.popularFact.count > 0 {
            self.alertLabel.isHidden = true
            self.popularTableView.isHidden = false
        } else {
            self.alertLabel.isHidden = false
            self.popularTableView.isHidden = true
        }
        
    }
}

extension PopularViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.popularFact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  "PopularTableViewCell", for: indexPath) as? PopularTableViewCell else{
            fatalError()
        }
        guard let fact = self.presenter.popularFact[indexPath.row].fact else { return UITableViewCell() }
        cell.configCell(factText: fact)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = FactDetailRouter.FactDetailVC() else { return }
        vc.presenter = FactDetailPresenter(view: vc)
        vc.presenter.factId = self.presenter.popularFact[indexPath.row].factId!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            self.presenter.skip += 10
            self.presenter.getPopularFact()
        }
    }
    
}

