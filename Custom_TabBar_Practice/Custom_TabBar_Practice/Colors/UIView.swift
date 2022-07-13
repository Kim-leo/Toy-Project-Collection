//
//  UIView.swift
//  Custom_TabBar_Practice
//
//  Created by 김승현 on 2022/07/13.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(cornerRadius: CGFloat, masksedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: masksedCorners)
    }
    
    
}

