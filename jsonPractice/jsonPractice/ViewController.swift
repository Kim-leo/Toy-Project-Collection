//
//  ViewController.swift
//  jsonPractice
//
//  Created by 김승현 on 2022/02/09.
//

import UIKit


class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
    }

    func parseJSON() {
        let url = Bundle.main.url(forResource: "storeAddress", withExtension: "json")
        
        do {
            let stringData = try String(contentsOf: url!, encoding: String.Encoding.utf8)
            let data = stringData.data(using: String.Encoding.utf8)
            let stores = try JSONDecoder().decode(storeAddress.self, from: data!)
            
            for obj in stores.Gangnam {
                print("name: \(obj.name), 도로명주소: \(obj.addressStreet), 지번주소: \(obj.addressLand)")
            }
            //print(stores.Gangnam)
            let currentGu = "송파구"
            
            /*
            func searchGUGUGU() {
                switch currentGu {
                case "강북구":
                    print(stores.Gangbuk)
                case "강남구":
                    print(stores.Gangnam)
                case "강동구":
                    print(stores.Gangdong)
                case "강서구":
                    print(stores.Gangseo)
                case "관악구":
                    print(stores.Gwanak)
                case "광진구":
                    print(stores.Gwangjin)
                case "구로구":
                    print(stores.Guro)
                case "금천구":
                    print(stores.GeumCheon)
                case "도봉구":
                    print(stores.Dobong)
                case "동대문구":
                    print(stores.Dongdaemun)
                case "동작구":
                    print(stores.Dongjak)
                case "마포구":
                    print(stores.Mapo)
                case "서대문구":
                    print(stores.Seodaemun)
                case "서초구":
                    print(stores.Seocho)
                case "성동구":
                    print(stores.Seongdong)
                case "성북구":
                    print(stores.Seongbuk)
                case "송파구":
                    print(stores.Songpa)
                case "양천구":
                    print(stores.Yangcheon)
                case "영등포구":
                    print(stores.Yeongdeungpo)
                case "용산구":
                    print(stores.Yongsan)
                case "은평구":
                    print(stores.Eunpyeong)
                case "종로구":
                    print(stores.Jongno)
                case "중구":
                    print(stores.Jung)
                case "중랑구":
                    print(stores.Jungnang)
                default:
                    print("oops")
                }
             
            }
             */
                
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}

