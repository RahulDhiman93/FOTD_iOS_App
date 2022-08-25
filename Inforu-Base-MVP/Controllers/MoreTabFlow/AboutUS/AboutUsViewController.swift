//
//  AboutUsViewController.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2022 Rahul. All rights reserved.
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
        LinearProgressHUD.sharedView.present(animated: true)
        self.aboutUsWebView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17"
        self.loadAboutUsPage()
        self.aboutUsWebView.navigationDelegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LinearProgressHUD.sharedView.dismiss(animated: true)
    }
    
    private func loadAboutUsPage() {
        guard let url = URL(string: AppConstants.aboutUs.replacingOccurrences(of: " ", with: "")) else { return }
        let urlRequest = URLRequest(url: url)
        self.aboutUsWebView.load(urlRequest)
    }

}

extension AboutUsViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      LinearProgressHUD.sharedView.dismiss(animated: true)
    }
}
