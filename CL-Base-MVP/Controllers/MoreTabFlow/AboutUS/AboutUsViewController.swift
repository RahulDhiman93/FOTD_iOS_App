//
//  AboutUsViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit
import WebKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var aboutUsWebView : WKWebView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "about us"
        self.aboutUsWebView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17"
        self.loadAboutUsPage()
        // Do any additional setup after loading the view.
    }
    
    private func loadAboutUsPage() {
        guard let url = URL(string: AppConstants.aboutUs.replacingOccurrences(of: " ", with: "")) else { return }
        let urlRequest = URLRequest(url: url)
        self.aboutUsWebView.load(urlRequest)
    }

}
