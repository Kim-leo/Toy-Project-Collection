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
    var noCommaArr = [String]()
    var noSpaceArr = [String]()
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
            print(priceArr)
            print(type(of: priceArr))
//            newArr = priceArr.compactMap { Float($0) ?? 0 }
//            print(newArr)
//            print(type(of: newArr))
            
            // priceArr내의 가격에 콤마를 지운 후
            for i in 0..<priceArr.count {
                if priceArr[i].contains(",") {
                    print("yes")
                    noCommaArr.append(priceArr[i].replacingOccurrences(of: ",", with: ""))
                    if priceArr[i].contains(" "){
                        noSpaceArr.append(noCommaArr[i].replacingOccurrences(of: " ", with: ""))
                    } else {
                        noSpaceArr.append(noCommaArr[i])
                    }
                } else {
                    priceArr.remove(at: i)
                }
            }
            // 가격 평균 구하기
            numArr = noSpaceArr.map{ Int($0)! }
            priceSum = numArr.reduce(0, +)
            priceAverage = priceSum! / numArr.count
            noSpaceArr.append(String(priceAverage!))    //가격 평균을 noSpaceArr 마지막에 추가
            
            print(priceArr)
            print(noCommaArr) //가격에서 콤마 제거
            print(noSpaceArr) //가격에서 띄어쓰기 제거
            print(numArr)     //String Array -> Int Array
           
            print(priceAverage!)

            
        } catch Exception.Error(let type, let message){
            print("Message: \(message)")
        } catch {
            print("error")
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noSpaceArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = noSpaceArr[indexPath.row]
        return cell
    }
    
    
}

