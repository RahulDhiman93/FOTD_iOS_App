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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupCollectionView()
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
        self.blogCollectionView.isPagingEnabled = true
        self.blogCollectionFlowLayout.minimumLineSpacing = 1
        self.blogCollectionFlowLayout.minimumInteritemSpacing = 1
      //  self.blogCollectionView.register( UINib(nibName: CollectionViewCell.DateSlotCollectionViewCell, bundle: Bundle.main), forCellWithReuseIdentifier: CollectionViewCell.DateSlotCollectionViewCell)
    }
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  "PopularTableViewCell", for: indexPath) as? PopularTableViewCell else{
            fatalError()
        }
        return cell
    }
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
