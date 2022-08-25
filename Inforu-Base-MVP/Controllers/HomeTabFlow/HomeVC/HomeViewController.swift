//
//  HomeViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 28/06/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit
import SkeletonView

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
        view.isSkeletonable = true
        view.showGradientSkeleton()
        view.startSkeletonAnimation()
//        LoadingShimmer.startCovering(self.view, with: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.getFeaturedFact()
       
    }
    
    private func setupTableView() {
        self.popularTableView.isSkeletonable = true
        self.popularTableView.delegate = self
        self.popularTableView.dataSource = self
        self.popularTableView.bounces = false
        self.popularTableView.separatorStyle = .none
        self.popularTableView.showsVerticalScrollIndicator = false
        self.popularTableView.estimatedRowHeight = 100.0
        self.popularTableView.register(UINib(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularTableViewCell")
    }
    
    private func setupCollectionView() {
        self.blogCollectionView.isSkeletonable = true
        self.blogCollectionView.delegate = self
        self.blogCollectionView.dataSource = self
        self.blogCollectionView.bounces = true
        self.blogCollectionView.isPagingEnabled = false
        self.blogCollectionView.showsHorizontalScrollIndicator = false
        self.blogCollectionView.register( UINib(nibName: "BlogCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "BlogCollectionViewCell")
    }
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        guard let vc = PopularRouter.PopularVC() else { fatalError() }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController : HomePresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func featuredSuccess() {
        view.hideSkeleton(transition: .crossDissolve(1.0))
        self.popularTableView.estimatedRowHeight = UITableView.automaticDimension
        self.popularTableView.reloadData()
        self.blogCollectionView.reloadData()
    }
}

extension HomeViewController : SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.popularFact.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
       return "PopularTableViewCell"
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
        vc.presenter.currentFactIndex = indexPath.row
        vc.presenter.totalFactForSwipe = self.presenter.popularFactWithSearchModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension HomeViewController : SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
       "BlogCollectionViewCell"
    }
    
    
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
        guard let factId = self.presenter.featuredFact[indexPath.item].factId else { return }
        vc.presenter = FactDetailPresenter(view: vc)
        vc.presenter.factId = factId
        vc.presenter.currentFactIndex = indexPath.item
        vc.presenter.totalFactForSwipe = self.presenter.featureFactWithSearchModel
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
