//
//  ViewController.swift
//  jsonPractice2
//
//  Created by 김승현 on 2022/06/04.
//

import UIKit

class ViewController: UITableViewController {
    
    // petitions를 담을 Petition Array
    var petitions = [Petition]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        /*
         URL이 유효할 때 if let 안의 코드가 실행된다.
         이는 강제로 URL을 unwrapping하는 것보다 나은데, 강제로 URL을 unwrapping할 경우에,
         만약 URL이 유효하지 않다면 에러가 생길 수 있으므로,
         url을 다룰 때에는 에러에 대비한 if let을 사용하는 것이 좋다.
         
         data 상수는 contentsOf 메소드를 사용하는 Data타입으로,
         이는 URL내의 content를 반환한다. 하지만, 인터넷 연결 끊김 같은 상황발생에 대비하여
         try? 를 사용한다.
         
         
         */
        
         // MARK: - try에 대한 설명
        /*
         try? - 에러 발생 시 nil을 반환한다.
         에러가 발생하지 않으면 반환 타입은 Optional이지만, 반환 타입이 없어도 사용 가능하다.
         try! - 에러 발생 시 Crash가 발생한다.
         반환 티입은 Non-Optional 즉, unwrapping이다.
         예외가 발생하지 않는다는 것을 보장하고 해당 함수를 호출할 때 사용한다.
         
         */
         
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            } else {
                showError()
            }
        } else {
            showError()
        }
        
    }
    
    // URL이 유효하지 않거나, JSON을 파싱할 때 오류 발생 시 작동하는 함수.
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed: please check your connenction and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    /*
     JSON을 parse할 함수 정의하기.
     
     JSONDecoder(): JSON과 Codable 객체를 변환하는데 전념하는 인스턴스.
     decoder.decode(): JSON데이터를 Petitions 객체로 변환하도록 요청하는 메소드.
     위 메소드또한 try?를 사용하는데 JSON을 Petitions로 변환할 때, 에러 발생 시를 대비한다.
     만약 JSON의 변환이 성공적으로 이루어졌다면, results 배열에
     petitions 프로퍼티를 할당하고 이를 tableView에 reload한다.
     */
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }

// MARK: -  tableView functions
    // 테이블뷰에 얼마나 많은 row를 표시할지 나타내는 함수. -> 여기서는 petitions의 개수만큼 나타낸다.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    // 테이블뷰의 각 셀을 어떻게 나타낼지 보여주는 함수.
    /*
     각 셀의 Identifier는 "Cell"이고, 이 셀은 계속 재사용된다.
     각 셀의 textLabel과 detailTextLabel은 각 petition의 title과 body를 나타내도록 하였다.
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    // 테이블뷰의 셀이 선택됐을 때 호출되는 함수.
    /*
     각 셀이 선택됐을 때, 해당 petitions의 내용 중 body를 detailItem으로 설정하고
     해당 body를 나타내는 DetailViewController를 표시한다.
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

