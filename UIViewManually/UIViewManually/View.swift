//
//  View.swift
//  UIViewManually
//

// MARK: - View.swift

import Foundation
import UIKit

class MyView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false     // 레이아웃을 직접 설정해주기 위해 다음 메소드 값을 false로 설정
        label.text = "타이틀입니다."
        label.textAlignment = .center
        label.textColor = .darkGray
        label.backgroundColor = .systemGray6
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) is not supported")
    }
    
}
