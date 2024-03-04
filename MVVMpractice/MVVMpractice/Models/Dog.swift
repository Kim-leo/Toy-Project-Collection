//
//  Dog.swift
//  MVVMpractice
//
//  Created by 김승현 on 3/4/24.
//

import Foundation

// MARK: - Model

class Dog {
    
    enum Breed {
        case maltese
        case pomeranian
        case pug
        case poodle
    }
    
    let name: String
    let birthday: Date
    let breed: Breed
    let imageName: String
    
    init(name: String = "갑돌이", birthday: Date = Date(timeIntervalSinceNow: (-2 * 86500 * 380)), breed: Breed = .pomeranian, imageName: String = "포메라니안.png") {
        self.name = name
        self.birthday = birthday
        self.breed = breed
        self.imageName = imageName
    }
}
