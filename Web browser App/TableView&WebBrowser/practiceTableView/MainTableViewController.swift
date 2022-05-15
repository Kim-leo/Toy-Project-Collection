//
//  MainTableViewController.swift
//  practiceTableView
//
//  Created by 김승현 on 2021/11/26.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var websites = ["apple.com", "google.com", "naver.com"]
    var webs = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Web browser"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        for item in websites {
            if item .hasSuffix(".com") {
                webs.append(item)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Web", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Web") as? WebViewController {
            vc.selectedWebsite = websites[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
    
