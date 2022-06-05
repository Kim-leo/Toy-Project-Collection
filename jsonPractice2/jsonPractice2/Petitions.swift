//
//  Petitions.swift
//  jsonPractice2
//
//  Created by 김승현 on 2022/06/04.
//

import Foundation

struct Petitions: Codable {
    var results: [Petition]
}

/*
 각각의 Petition을 담는 Petitions라는 Petition으로 구성된 배열을 results라는 이름으로 정의한다.
 
 ViewController에서 class내부에
 " var petitions = [Petition]() "
 가 정의됐다면, JSON을 parse할 수 있다.
 즉, JSON 파일 내에서 원하는 내용을 처리하여 코드로 다룰 수 있게 할 수 있다.
 */
