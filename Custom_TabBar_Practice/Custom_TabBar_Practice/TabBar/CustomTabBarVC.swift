//
//  CustomTabBarVC.swift
//  Custom_TabBar_Practice
//
//  Created by 김승현 on 2022/07/12.
//

import Foundation
import UIKit

let pinkColor = UIColor(rgb: 0xEE4E75)
let lightPinkColor = UIColor(rgb: 0xEDC0CB)
let lightPinkColor2 = UIColor(rgb: 0xEFA9BA)
let lightGrayColor = UIColor(rgb: 0xE7E7E7)
let dartGrayColor = UIColor(rgb: 0xBDBDBD)

class CustomTabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    let mainButton = UIButton()
    let roomButton = UIButton()
    let middleButton = UIButton()
    let bookmarkButton = UIButton()
    let mypageButton = UIButton()
    let clearView = UIView()
    let pinkView = UIView()
    
    let pinkLineArr: [UIView] = {
        var viewArr = [UIView]()
        for _ in 0...3 {
            let line = UIView()
            line.backgroundColor = .clear
            line.translatesAutoresizingMaskIntoConstraints = false
            line.widthAnchor.constraint(equalToConstant: 40).isActive = true
            line.heightAnchor.constraint(equalToConstant: 2).isActive = true
            viewArr.append(line)
        }
        return viewArr
    }()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tabBar.backgroundColor = UIColor.white
        self.delegate = self
        self.selectedIndex = 2
        
        mainButtonLayout()
        MiddleButtonLayout()
        roomButtonLayout()
        bookmarkButtonLayout()
        mypageButtonLayout()
        
    }
    
    func pinkLines() {
       
    }
    
    func mainButtonLayout() {
        mainButton.backgroundColor = lightGrayColor
        mainButton.layer.masksToBounds = true
        mainButton.layer.cornerRadius = 20
        mainButton.setTitle("메인", for: .normal)
        mainButton.setTitleColor(dartGrayColor, for: .normal)
        mainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        
        self.view.addSubview(mainButton)
        
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        mainButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        mainButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        mainButton.centerYAnchor.constraint(equalTo: self.tabBar.centerYAnchor, constant: -10).isActive = true
        mainButton.leadingAnchor.constraint(equalTo: self.tabBar.leadingAnchor, constant: 25).isActive = true
        
        mainButton.addTarget(self, action: #selector(mainButtonAction), for: .touchUpInside)
        
        self.view.addSubview(pinkLineArr[0])
        pinkLineArr[0].topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        pinkLineArr[0].centerXAnchor.constraint(equalTo: mainButton.centerXAnchor).isActive = true
    }
    
    func roomButtonLayout() {
        roomButton.backgroundColor = lightGrayColor
        roomButton.layer.masksToBounds = true
        roomButton.layer.cornerRadius = 20
        roomButton.setTitle("주변", for: .normal)
        roomButton.setTitleColor(dartGrayColor, for: .normal)
        roomButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        
        self.view.addSubview(roomButton)
        
        roomButton.translatesAutoresizingMaskIntoConstraints = false
        roomButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        roomButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        roomButton.centerYAnchor.constraint(equalTo: self.tabBar.centerYAnchor, constant: -10).isActive = true
        roomButton.trailingAnchor.constraint(equalTo: clearView.leadingAnchor, constant: -35).isActive = true
        
        roomButton.addTarget(self, action: #selector(roomButtonAction), for: .touchUpInside)
        
        self.view.addSubview(pinkLineArr[1])
        pinkLineArr[1].topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        pinkLineArr[1].centerXAnchor.constraint(equalTo: roomButton.centerXAnchor).isActive = true
    }
    
    func MiddleButtonLayout() {
        clearView.backgroundColor = .clear
        clearView.layer.masksToBounds = true
        clearView.layer.cornerRadius = 15
        
        pinkView.backgroundColor = pinkColor
        
        pinkView.layer.masksToBounds = true
        pinkView.roundCorners(cornerRadius: 12, masksedCorners: [.layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner])

        middleButton.backgroundColor = lightPinkColor2
        middleButton.layer.cornerRadius = 20
        middleButton.setTitle("길찾기", for: .normal)
        middleButton.setTitleColor(pinkColor, for: .normal)
        middleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        
        self.view.addSubview(clearView)
        clearView.addSubview(pinkView)
        pinkView.addSubview(middleButton)
        
        clearView.translatesAutoresizingMaskIntoConstraints = false
        clearView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        clearView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        clearView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
        clearView.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: 20).isActive = true
        
        pinkView.translatesAutoresizingMaskIntoConstraints = false
        pinkView.centerXAnchor.constraint(equalTo: clearView.centerXAnchor).isActive = true
        pinkView.centerYAnchor.constraint(equalTo: clearView.centerYAnchor).isActive = true
        pinkView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        pinkView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        middleButton.centerXAnchor.constraint(equalTo: clearView.centerXAnchor).isActive = true
        middleButton.centerYAnchor.constraint(equalTo: clearView.centerYAnchor).isActive = true
        middleButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        middleButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        middleButton.addTarget(self, action: #selector(middleButtonAction), for: .touchUpInside)
    
        self.view.layoutIfNeeded()
    }
    
    func bookmarkButtonLayout() {
        bookmarkButton.backgroundColor = lightGrayColor
        bookmarkButton.layer.masksToBounds = true
        bookmarkButton.layer.cornerRadius = 20
        bookmarkButton.setTitle("즐겨찾기", for: .normal)
        bookmarkButton.setTitleColor(dartGrayColor, for: .normal)
        bookmarkButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        
        self.view.addSubview(bookmarkButton)
        
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bookmarkButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bookmarkButton.centerYAnchor.constraint(equalTo: self.tabBar.centerYAnchor, constant: -10).isActive = true
        bookmarkButton.leadingAnchor.constraint(equalTo: clearView.trailingAnchor, constant: 35).isActive = true
        
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonAction), for: .touchUpInside)
        
        self.view.addSubview(pinkLineArr[2])
        pinkLineArr[2].topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        pinkLineArr[2].centerXAnchor.constraint(equalTo: bookmarkButton.centerXAnchor).isActive = true
    }
    
    func mypageButtonLayout() {
        mypageButton.backgroundColor = lightGrayColor
        mypageButton.layer.masksToBounds = true
        mypageButton.layer.cornerRadius = 20
        mypageButton.setTitle("마이 페이지", for: .normal)
        mypageButton.setTitleColor(dartGrayColor, for: .normal)
        mypageButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 8)
        
        self.view.addSubview(mypageButton)
        
        mypageButton.translatesAutoresizingMaskIntoConstraints = false
        mypageButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        mypageButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        mypageButton.centerYAnchor.constraint(equalTo: self.tabBar.centerYAnchor, constant: -10).isActive = true
        mypageButton.trailingAnchor.constraint(equalTo: self.tabBar.trailingAnchor, constant: -20).isActive = true
        
        mypageButton.addTarget(self, action: #selector(mypageButtonAction), for: .touchUpInside)
        
        self.view.addSubview(pinkLineArr[3])
        pinkLineArr[3].topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        pinkLineArr[3].centerXAnchor.constraint(equalTo: mypageButton.centerXAnchor).isActive = true
    }
    
    @objc func mainButtonAction(sender: UIButton) {
        self.selectedIndex = 0
        pinkLines()
        
        mainButton.backgroundColor = lightPinkColor
        mainButton.setTitleColor(pinkColor, for: .normal)
        
        roomButton.backgroundColor = lightGrayColor
        roomButton.setTitleColor(dartGrayColor, for: .normal)
        
        bookmarkButton.backgroundColor = lightGrayColor
        bookmarkButton.setTitleColor(dartGrayColor, for: .normal)
        
        mypageButton.backgroundColor = lightGrayColor
        mypageButton.setTitleColor(dartGrayColor, for: .normal)
        
        pinkLineArr[0].backgroundColor = pinkColor
        pinkLineArr[1].backgroundColor = .clear
        pinkLineArr[2].backgroundColor = .clear
        pinkLineArr[3].backgroundColor = .clear
    }
    
    @objc func roomButtonAction(sender: UIButton) {
        self.selectedIndex = 1
        pinkLines()
        
        mainButton.backgroundColor = lightGrayColor
        mainButton.setTitleColor(dartGrayColor, for: .normal)
        
        roomButton.backgroundColor = lightPinkColor
        roomButton.setTitleColor(pinkColor, for: .normal)
        
        bookmarkButton.backgroundColor = lightGrayColor
        bookmarkButton.setTitleColor(dartGrayColor, for: .normal)
        
        mypageButton.backgroundColor = lightGrayColor
        mypageButton.setTitleColor(dartGrayColor, for: .normal)
        
        pinkLineArr[0].backgroundColor = .clear
        pinkLineArr[1].backgroundColor = pinkColor
        pinkLineArr[2].backgroundColor = .clear
        pinkLineArr[3].backgroundColor = .clear
    }
    
    @objc func middleButtonAction(sender: UIButton) {
        self.selectedIndex = 2
        
        mainButton.backgroundColor = lightGrayColor
        mainButton.setTitleColor(dartGrayColor, for: .normal)
        
        roomButton.backgroundColor = lightGrayColor
        roomButton.setTitleColor(dartGrayColor, for: .normal)
        
        bookmarkButton.backgroundColor = lightGrayColor
        bookmarkButton.setTitleColor(dartGrayColor, for: .normal)
        
        mypageButton.backgroundColor = lightGrayColor
        mypageButton.setTitleColor(dartGrayColor, for: .normal)
        
        for i in 0...3 {
            pinkLineArr[i].backgroundColor = .clear
        }
    }
    
    @objc func bookmarkButtonAction(sender: UIButton) {
        self.selectedIndex = 3
        pinkLines()
        
        mainButton.backgroundColor = lightGrayColor
        mainButton.setTitleColor(dartGrayColor, for: .normal)
        
        roomButton.backgroundColor = lightGrayColor
        roomButton.setTitleColor(dartGrayColor, for: .normal)

        bookmarkButton.backgroundColor = lightPinkColor
        bookmarkButton.setTitleColor(pinkColor, for: .normal)
        
        mypageButton.backgroundColor = lightGrayColor
        mypageButton.setTitleColor(dartGrayColor, for: .normal)
        
        pinkLineArr[0].backgroundColor = .clear
        pinkLineArr[1].backgroundColor = .clear
        pinkLineArr[2].backgroundColor = pinkColor
        pinkLineArr[3].backgroundColor = .clear
    }
    
    @objc func mypageButtonAction(sender: UIButton) {
        self.selectedIndex = 4
        pinkLines()
        
        mainButton.backgroundColor = lightGrayColor
        mainButton.setTitleColor(dartGrayColor, for: .normal)
        
        roomButton.backgroundColor = lightGrayColor
        roomButton.setTitleColor(dartGrayColor, for: .normal)
       
        bookmarkButton.backgroundColor = lightGrayColor
        bookmarkButton.setTitleColor(dartGrayColor, for: .normal)
        
        mypageButton.backgroundColor = lightPinkColor
        mypageButton.setTitleColor(pinkColor, for: .normal)
        
        pinkLineArr[0].backgroundColor = .clear
        pinkLineArr[1].backgroundColor = .clear
        pinkLineArr[2].backgroundColor = .clear
        pinkLineArr[3].backgroundColor = pinkColor
    }
}

