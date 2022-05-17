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
    var numArr = [Int]()
    var priceSum: Int?
    var priceAverage: Int?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
 
        crawlWebSite()
        
        print("\n")
        
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
//            print(priceArr)
//            print(type(of: priceArr))
            
            // priceArr내의 가격의 콤마와 스페이스를 지운 후, 정수형배열(numArr)로 저장
            for i in 0..<priceArr.count {
                var noComma = ""
                var noSpace = ""
                if priceArr[i].contains(",") {
                    noComma = priceArr[i].replacingOccurrences(of: ",", with: "")
                    noSpace = noComma.replacingOccurrences(of: " ", with: "")
                    numArr.append(Int(noSpace) ?? 0)
                } else {
                    priceArr.remove(at: i)
                }
            }
            priceSum = numArr.reduce(0, +)
            priceAverage = priceSum! / numArr.count
            numArr.append(priceAverage!)    //가격 평균을 numArr 마지막에 추가
            
            print(numArr)
            
        } catch Exception.Error(let type, let message){
            print("Message: \(message)")
        } catch {
            print("error")
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = String(numArr[indexPath.row])
        return cell
    }
    
    
}

