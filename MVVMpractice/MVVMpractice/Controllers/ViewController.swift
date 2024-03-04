//
//  ViewController.swift
//  MVVMpractice
//
//  Created by 김승현 on 2/29/24.
//

import UIKit

class ViewController: UIViewController {
    
    let dogView = DogView()
    let viewModel  = DogViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.configure(dogView)
        
        self.view.addSubview(dogView)
        
        setupUI()
    }
    
    func setupUI() {
        dogView.translatesAutoresizingMaskIntoConstraints = false
        dogView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 135).isActive = true
        dogView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dogView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        dogView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
    }
}

extension DogViewModel {
    func configure(_ view: DogView) {
        view.nameLabel.text = "이름: \(name)"
        view.imageName = imageName
        view.ageLabel.text = "나이: \(ageText)"
        view.adoptionFeeLabel.text = "입양가: \(adoptionFeeText) 원"
    }
}
