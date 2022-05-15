//
//  WebViewController.swift
//  practiceTableView
//
//  Created by 김승현 on 2021/11/26.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var selectedWebsite: String = ""
    
    var websiteToLoad: String?
    
    var websites = ["apple.com", "google.com", "naver.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let url = URL(string: "https://" + selectedWebsite)!
        webView.load(URLRequest(url: url))
         
        webView.allowsBackForwardNavigationGestures = true
        
        
        
        
    }
    
    func openPage(action: UIAlertAction) {
        let actionTitle = action.title
        let url = URL(string: "https://" + actionTitle!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

  

}
