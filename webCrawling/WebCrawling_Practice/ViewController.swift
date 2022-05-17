//
//  ViewController.swift
//  WebCrawling_Practice
//
//  Created by 김승현 on 2022/05/16.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var priceArr = [String]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
 
        crawlWebSite()
        
    }

    func crawlWebSite() {
        let url = "https://www.daangn.com/search/%EC%88%98%EC%9C%A0%20%EB%83%89%EC%9E%A5%EA%B3%A0"
        guard let myUrl = URL(string: url) else { return }
        do {
            
            let html = try String(contentsOf: myUrl, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            
            let headerTitle = try doc.title()
            print(headerTitle)
            
            // 가격 정보 추출 후 -> 테이블뷰 셀에 표시
            let price: Elements = try doc.select(".article-info").select(".article-price")
            priceArr = try price.text().components(separatedBy: "원") //type: Array<String>
            print(priceArr)

            
        } catch Exception.Error(let type, let message){
            print("Message: \(message)")
        } catch {
            print("error")
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = priceArr[indexPath.row]
        return cell
    }
    
    
}

