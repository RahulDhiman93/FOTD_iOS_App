//
//  HomeViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 28/06/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var blogCollectionView: UICollectionView!
    @IBOutlet weak var blogCollectionFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var popularTableView: UITableView!
    
    var presenter : HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomePresenter(view : self)
        self.setupCollectionView()
        self.setupTableView()
        self.presenter.getFeaturedFact()
        // Do any additional setup after loading the view.
    }
    
    private func setupTableView() {
        self.popularTableView.delegate = self
        self.popularTableView.dataSource = self
        self.popularTableView.bounces = false
        self.popularTableView.separatorStyle = .none
        self.popularTableView.showsVerticalScrollIndicator = false
        self.popularTableView.register(UINib(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularTableViewCell")
    }
    
    private func setupCollectionView() {
        self.blogCollectionView.delegate = self
        self.blogCollectionView.dataSource = self
        self.blogCollectionView.bounces = true
        self.blogCollectionView.isPagingEnabled = false
        self.blogCollectionView.showsHorizontalScrollIndicator = false
//        self.blogCollectionFlowLayout.minimumLineSpacing = 1
//        self.blogCollectionFlowLayout.minimumInteritemSpacing = 1
        self.blogCollectionView.register( UINib(nibName: "BlogCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "BlogCollectionViewCell")
    }
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        
    }
}

extension HomeViewController : HomePresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func featuredSuccess() {
        self.popularTableView.reloadData()
        self.blogCollectionView.reloadData()
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
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
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.featuredFact.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlogCollectionViewCell" , for: indexPath) as? BlogCollectionViewCell else {
            fatalError()
        }
        cell.model = self.presenter.featuredFact[indexPath.item]
        cell.setupCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = FactDetailRouter.FactDetailVC() else { return }
        vc.presenter = FactDetailPresenter(view: vc)
        vc.presenter.factId = self.presenter.featuredFact[indexPath.item].factId!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size : CGSize = CGSize(width: self.blogCollectionView.frame.width/2.5, height: self.blogCollectionView.frame.height)
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
