//
//  TTReplicatorLayer.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/8.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTReplicatorLayer: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLayer() {
        let sublayer = CALayer()
        sublayer.frame = bounds
        sublayer.backgroundColor = UIColor.white.cgColor
        sublayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        sublayer.add(scaleYAnimation(), forKey: "scaleAnimation")
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = bounds
        // 设置复制层中包含子层的个数
        replicatorLayer.instanceCount = 4
        // 设置子层相对于前一个层的偏移量
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(5, 0, 0)
        // 设置子层相对于前一个层的延迟时间
        replicatorLayer.instanceDelay = 0.2
        // 设置层的颜色 (前提是要设置层的背景颜色，如果没有设置背景颜色，默认是透明的，再设置这个属性不会有效果。
        replicatorLayer.instanceColor = Constants.Colors.button.cgColor
        // 需要把子层添加到复制层中, 复制层按照前面设置的参数自动复制
        replicatorLayer.addSublayer(sublayer)
        
        // 将复制层添加到view.layer显示
        layer.addSublayer(replicatorLayer)
    }
    
    private func scaleYAnimation() -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: "transform.scale.y")
        anim.toValue = 0.1
        anim.duration = 0.4
        anim.autoreverses = true
        anim.repeatCount = MAXFLOAT
        anim.isRemovedOnCompletion = false
        return anim
    }
}
