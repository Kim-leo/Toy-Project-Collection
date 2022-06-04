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
