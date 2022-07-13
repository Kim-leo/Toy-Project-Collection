//
//  TabBarVC.swift
//  Custom_TabBar_Practice
//
//  Created by 김승현 on 2022/07/12.
//

import UIKit

class TabBarVC: UITabBar {
    
    let pinkColor = UIColor(rgb: 0xF27A98)
    let lightPinkColor = UIColor(rgb: 0xEFA9BA)

    private var shapeLayer: CALayer?
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = lightGrayColor.cgColor
        shapeLayer.shadowOpacity = 0.3
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
        self.unselectedItemTintColor = UIColor.gray
        self.tintColor = pinkColor
        
    }
    
    func createPath() -> CGPath {
        let centerWidth = self.frame.width / 2

        //let path = UIBezierPath(roundedRect: CGRect(x: centerWidth - 30, y: -10, width: 60, height: 60), cornerRadius: 15)
        let radius: CGFloat = 10
            
        let padding: CGFloat = 30
        
                
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: centerWidth - padding, y: 0))
        
        ///path.addQuadCurve(to: CGPoint(x: centerWidth - padding, y: radius), controlPoint: CGPoint(x: centerWidth - padding, y: 0))
        path.addLine(to: CGPoint(x: centerWidth - padding, y: 40))
        path.addQuadCurve(to: CGPoint(x: centerWidth - padding + radius, y: 50), controlPoint: CGPoint(x: centerWidth - padding, y: 50))
        
        path.addLine(to: CGPoint(x: centerWidth + padding - radius, y: 50))
        path.addQuadCurve(to: CGPoint(x: centerWidth + padding, y: 40), controlPoint: CGPoint(x: centerWidth + padding, y: 50))
        path.addLine(to: CGPoint(x: centerWidth + padding, y: radius))
        
        
        path.addLine(to: CGPoint(x: centerWidth + padding, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        
        
        path.fill()
        
        
        return path.cgPath
    }
    
    
            
            
            
           
        

}
