//
//  ViewController.swift
//  what to wear today
//
//  Created by 김승현 on 2022/06/18.
//

import UIKit

class ViewController: UIViewController {

    // 받아온 데이터를 저장할 프로퍼티
    var weather: Weather?
    var main: Main?
    var name: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherSerivce().getWeather { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weather = weatherResponse.weather.first
                    self.main = weatherResponse.main
                    self.name = weatherResponse.name
                }
            case .failure(_ ):
                print("error..ㅠㅠ")
            }
        }
        
    }

    

}

