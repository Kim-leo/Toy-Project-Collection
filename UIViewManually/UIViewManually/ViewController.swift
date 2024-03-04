//
//  ViewController.swift
//  UIViewManually
//
//  Created by 김승현 on 3/4/24.
//

// MARK: - ViewController.swift

import UIKit

class ViewController: UIViewController {

    let myView = MyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(myView)
        setupUI()
    }

    func setupUI() {
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        myView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}

