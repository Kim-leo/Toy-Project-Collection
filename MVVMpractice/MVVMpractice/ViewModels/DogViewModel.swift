//
//  DogViewModel.swift
//  MVVMpractice
//
//  Created by 김승현 on 3/4/24.
//

import Foundation

// MARK: - ViewModel

class DogViewModel {
    let dog: Dog
    let calendar: Calendar
    
    init() {
        self.dog = Dog()
        self.calendar = Calendar(identifier: .gregorian)
    }
    
    var name: String {
        return dog.name
    }
    
    var imageName: String {
        return dog.imageName
    }
    
    var ageText: String {
        let today = calendar.startOfDay(for: Date())
        let birthday = calendar.startOfDay(for: dog.birthday)
        let components = calendar.dateComponents([.year], from: birthday, to: today)
        let age = components.year == nil ? 0 : components.year!
        return "\(age) years old"
    }
    
    var adoptionFeeText: String {
        switch dog.breed {
        case .maltese:
            return "200,000"
        case .pomeranian:
            return "500,000"
        case .pug:
            return "400,000"
        case .poodle:
            return "600,000"
        }
    }
}
