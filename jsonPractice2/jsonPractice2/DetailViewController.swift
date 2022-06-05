//
//  DetailViewController.swift
//  jsonPractice2
//
//  Created by 김승현 on 2022/06/04.
//


// 각 petition 내용을 표시할 DetailViewController.

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // detailItem에 어떤 data가 전달되지 않는 것을 방지하기 위해 guard 사용.
        guard let detailItem = detailItem else { return }
        let html = """
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style> body { font-size: 150%; } </style>
</head>
<body>
\(detailItem.body)
</body>
</html>
"""
        // WKWebView안에 html코드를 로드하는 코드.
        webView.loadHTMLString(html, baseURL: nil)
    }
    

    

}
