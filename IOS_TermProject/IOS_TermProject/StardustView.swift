//
//  StardustView.swift
//  Anagrams
//
//  Created by  kpugame on 23/05/2019.
//  Copyright © 2019 Caroline. All rights reserved.
//

import Foundation
import UIKit

class StardustView: UIView{
    private var emitter: CAEmitterLayer!
    
    override class var layerClass: AnyClass{
        return CAEmitterLayer.self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init(frame: )")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        emitter = self.layer as? CAEmitterLayer
        emitter.emitterPosition = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        emitter.emitterSize = self.bounds.size
        emitter.renderMode = CAEmitterLayerRenderMode.additive
        emitter.emitterShape = CAEmitterLayerEmitterShape.rectangle
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if self.superview == nil{
            return
        }
        let texture: UIImage? = UIImage(named: "particle")
        assert(texture != nil, "particle image not found")
        let emitterCell = CAEmitterCell()
        
        emitterCell.name = "cell"
        emitterCell.contents = texture?.cgImage
        emitterCell.birthRate = 200
        emitterCell.lifetime = 0.25
        emitterCell.redRange = 0.99
        emitterCell.redSpeed = -0.33
        emitterCell.xAcceleration = -200
        emitterCell.yAcceleration = 100
        emitterCell.velocity = 160
        emitterCell.velocityRange = 40
        emitterCell.scaleRange = 0.3
        emitterCell.scaleSpeed = -0.2
        emitterCell.emissionRange = CGFloat(Double.pi*2)
        emitter.emitterCells = [emitterCell]
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.25, execute: {self.removeFromSuperview()})
        
    }
}
