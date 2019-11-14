//
//  HomeViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 28/06/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

enum numberOfSectionsOnHome : Int {
    case Categories
    case Trending
    static let count = Trending.rawValue + 1
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView : UITableView!
    
    var todaysFactModel : RandomFactModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupTableView()
        self.getTodaysFact()
        // Do any additional setup after loading the view.
    }
    
    class func initiate() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        return controller
    }
    
    private func getTodaysFact() {
        
        UserAPI.share.getTodaysFact(callback: { [weak self] response , error in
            
            guard let response = response, error == nil else {
                ErrorView.showWith(message: error?.localizedDescription ?? "Server Error, Please try again!", isErrorMessage: true) {
                }
                return
            }
            
            self?.todaysFactModel = RandomFactModel(json: response)
            
        })
        
    }
    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupTableView() {
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
       // self.homeTableView.register(UINib(nibName: "", bundle: nil), forCellReuseIdentifier: "")
    }

}

extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSectionsOnHome.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch numberOfSectionsOnHome(rawValue: section)! {
        case .Categories:
            if let view = Bundle.main.loadNibNamed("CategoriesViewHeader", owner: self, options: nil)?[0] as? CategoriesViewHeader {
                return view
            }
            return UIView()
        default:
            return UIView()
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch numberOfSectionsOnHome(rawValue: section)! {
        case .Categories:
            return 40.0
        default:
            return 0.001
        }
    }
    
}
