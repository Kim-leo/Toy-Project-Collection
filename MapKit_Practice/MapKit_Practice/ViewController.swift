//
//  ViewController.swift
//  MapKit_Practice
//
//  Created by 김승현 on 2022/05/18.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let tableViewCellNames = ["simple map", "map with pin", "map with address"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableViewCellNames[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let firstViewController = firstViewController()
            self.navigationController?.pushViewController(firstViewController, animated: true)
        case 1:
            let secondViewContrller = secondViewController()
            self.navigationController?.pushViewController(secondViewContrller, animated: true)
        case 2:
            let thirdViewController = thirdViewController()
            self.navigationController?.pushViewController(thirdViewController, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
