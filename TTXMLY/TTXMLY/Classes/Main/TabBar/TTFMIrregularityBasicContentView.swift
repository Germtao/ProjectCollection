//
//  TTFMIrregularityBasicContentView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/1.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class TTFMIrregularityBasicContentView: TTFMBouncesContentView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor(red: 254 / 255.0, green: 73 / 255.0, blue: 42 / 255.0, alpha: 1.0)
        iconColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor(red: 254 / 255.0, green: 73 / 255.0, blue: 42 / 255.0, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TTFMIrregularityContentView: ESTabBarItemContentView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = UIColor(red: 250 / 255.0, green: 48 / 255.0, blue: 32 / 255.0, alpha: 1.0)
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor(white: 235 / 255.0, alpha: 1.0).cgColor
        imageView.layer.cornerRadius = 25.0
        insets = UIEdgeInsets(top: -23.0, left: 0.0, bottom: 0.0, right: 0.0)
        let transform = CGAffineTransform.identity
        imageView.transform = transform
        superview?.bringSubviewToFront(self)
        
        textColor = UIColor(white: 1.0, alpha: 1.0)
        highlightTextColor = UIColor(white: 1.0, alpha: 1.0)
        iconColor = UIColor(white: 1.0, alpha: 1.0)
        highlightIconColor = UIColor(white: 1.0, alpha: 1.0)
        backdropColor = .clear
        highlightBackdropColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let p = CGPoint(x: point.x - imageView.frame.origin.x, y: point.y - imageView.frame.origin.y)
        return sqrt(pow(imageView.bounds.width / 2.0 - p.x, 2) + pow(imageView.bounds.height /  2.0 - p.y, 2)) < imageView.bounds.width / 2.0
    }
    
    override func updateLayout() {
        super.updateLayout()
        imageView.sizeToFit()
        imageView.center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    }
}
