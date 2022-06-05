//
//  Petitions.swift
//  jsonPractice2
//
//  Created by 김승현 on 2022/06/04.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

/*
 각 petition는 title, body text, signatureCount 등으로 구성되어 있다.
 이는 JSON의 하나의 petition을 담은 Petition이라 불리는 struct 구조로 정의해야 함을 의미한다.
 
 Swift는 JSON을 다룰 때, Codable이라는 내장 프로토콜을 제공하는데
 Codable의 의미는 데이터와 JSON간의 변환을 허용한다는 의미이다.
 
 title은 String,
 body는 String,
 signatureCount는 Int 타입으로 되어있기 때문에
 위와 같이 자료형을 정의해주어야 한다.
 */
