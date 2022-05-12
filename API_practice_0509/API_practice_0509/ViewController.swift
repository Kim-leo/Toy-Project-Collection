//
//  ViewController.swift
//  API_practice_0509
//
//  Created by 김승현 on 2022/05/09.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var currentTime: UILabel!
    
    @IBOutlet weak var userId: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var responseView: UITextView!
    
    // MARK: - GET 방식 호출 - 1
    @IBAction func callCurrentTime(_ sender: UIButton) {
        print("현재 서버 시간 확인")
        
        if let url = URL(string: "http://worldclockapi.com/api/json/est/now") {
            var request = URLRequest.init(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data else { return }
                print("data \(data)")
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let currentDateTime = json["currentDateTime"] as? String {
                        print("time: \(currentDateTime)")
                        
                        DispatchQueue.main.async {
                            self.currentTime.text = currentDateTime
                            self.currentTime.sizeToFit()
                        }
                        //self.alert("완료")
                    }
                } // Json - end
            }.resume() //URLSession - end
        } //url - end
    }
    
    // MARK: - POST
    @IBAction func postAction(_ sender: UIButton) {
        print("post 확인")
        
        // 전송할 값
        let userId = self.userId.text!
        let name = self.name.text!
        let param = "userId=\(userId)&name=\(name)"
        let paramData = param.data(using: .utf8)
        
        // URL 객체 정의
        let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/echo")
        
        // URLRequest 객체 정의
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            //서버가 응답이 없거나 통신이 실패
            if let e = error {
                print("Error")
                return
            }
            
            //응답처리 로직
            DispatchQueue.main.async {
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    
                    guard let jsonObject = object else { return }
                    
                    //JSON 결과 값을 추출
                    let result = jsonObject["result"] as? String
                    let timestamp = jsonObject["timestamp"] as? String
                    let userId = jsonObject["userId"] as? String
                    let name = jsonObject["name"] as? String
                    
                    if result == "SUCCESS" {
                        self.responseView.text = "아이디: \(userId!)" + "\n"
                        + "이름: \(name!)" + "\n"
                        + "응답시간: \(timestamp!)" + "\n"
                        + "요청방식: x-www-form-urlencoded" + "\n"
                    }
                } catch let e as NSError {
                    print("An error has occured while parsing JSONObject: \(e.localizedDescription)")
                }
            }
        } // task - end
        
        // post 전송
        task.resume()
        
    }
    
    
    
    
    // MARK: - JSON
    @IBAction func jsonAction(_ sender: UIButton) {
        print("json 확인")
        
        let userId = self.userId.text!
        let name = self.name.text!
        let param = ["userId" : userId, "name": name] // JSON 객체로 전송할 딕셔너리
        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        
        // URL 객체 정의
        let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/echoJSON")
        
        // URLRequest 객체 정의
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        // HTTP 메시지 헤더
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")
        
        // URLSession 객체를 통해 전송, 응답값 처리
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // 서버가 응답이 없거나 통신실패
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                return
            }
            // 응답 처리 로직
            DispatchQueue.main.async() {
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    guard let jsonObject = object else { return }
                    
                    // JSON 결과값을 추출
                    let result = jsonObject["result"] as? String
                    let timestamp = jsonObject["timestamp"] as? String
                    let userId = jsonObject["userId"] as? String
                    let name = jsonObject["name"] as? String
                    
                    // 결과가 성공일 경우
                    if result == "SUCCESS" {
                        self.responseView.text = "아이디: \(userId!)" + "\n"
                        + "이름: \(name!)" + "\n"
                        + "응답결과: \(result!)" + "\n"
                        + "응답시간: \(timestamp!)" + "\n"
                        + "요청방식: application/json"
                    }
                } catch let e as NSError {
                    print("An error has occurred while parsing JSONObject: \(e.localizedDescription)")
                }
            }
        }
         
        // POST 전송
        task.resume()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("yes")
        responseView.backgroundColor = .systemGray5
        responseView.text = ""
    }

    @IBAction func nextBtn(_ sender: UIButton) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController")

        self.navigationController?.pushViewController(pushVC!, animated: true)
    }
    
}

