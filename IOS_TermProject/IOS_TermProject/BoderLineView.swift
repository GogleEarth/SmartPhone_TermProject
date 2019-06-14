//
//  BoderLineView.swift
//  IOS_TermProject
//
//  Created by  kpugame on 14/06/2019.
//  Copyright © 2019  kpugame. All rights reserved.
//

import UIKit

@IBDesignable class BoderLineView: UIView {
    
    override func draw(_ rect: CGRect) {
        let plusHeight : CGFloat = 3.0
        let plusPath = UIBezierPath()
        
        plusPath.lineWidth = plusHeight
        
        plusPath.move(to: CGPoint(x: 0, y: 0))
        
        plusPath.addLine(to: CGPoint(x: 0, y: bounds.height))
        
        plusPath.move(to: CGPoint(x: bounds.width, y: 0))
            
        plusPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        
        plusPath.move(to: CGPoint(x: 0, y: bounds.height))
        
        plusPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        
        plusPath.move(to: CGPoint(x: 0, y: 0))
        
        plusPath.addLine(to: CGPoint(x: bounds.width, y: 0))
        
        UIColor.black.setStroke()
        
        plusPath.stroke()
    }

}
