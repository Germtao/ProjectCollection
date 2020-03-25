//
//  IdCardFloatingView.swift
//  SwiftCollection
//
//  Created by QDSG on 2020/3/25.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

private let isIPhone5or5cor5sorSE: Bool = UIScreen.main.bounds.height == 568.0
private let isIPhone6or6sor7: Bool = UIScreen.main.bounds.height == 667.0
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
let kBounds = UIScreen.main.bounds

class IdCardFloatingView: UIView {

    private var type: CameraType = .idcardFront
    
    // MARK: - 懒加载
    lazy var idcardWindowLayer: CAShapeLayer = {
        let windowLayer = CAShapeLayer()
        windowLayer.position = self.layer.position
        windowLayer.cornerRadius = 15
        windowLayer.borderColor = UIColor.white.cgColor
        windowLayer.borderWidth = 2
        return windowLayer
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
}

extension IdCardFloatingView {
    convenience init(type: CameraType) {
        self.init(frame: kBounds)
        self.type = type
        backgroundColor = .clear
        setupUI()
    }
}

extension IdCardFloatingView {
    private func setupUI() {
        layer.addSublayer(idcardWindowLayer)
        let width: CGFloat = isIPhone5or5cor5sorSE ? 240 : (isIPhone6or6sor7 ? 240 : 270)
        idcardWindowLayer.bounds = CGRect(x: 0, y: 0, width: width, height: width * 1.574)
        drawPath()
        
        textLabel.text = type.idcardTitle
        let w = kScreenH
        let h: CGFloat = 20
        let x = (kScreenW - w) / 2 - idcardWindowLayer.frame.width / 2 - 20
        let y = (kScreenH - h) / 2
        textLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        textLabel.transform = CGAffineTransform(rotationAngle: .pi / 2)
        addSubview(textLabel)
        
        let imageView = UIImageView()
        imageView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        
        var imageX: CGFloat = 0
        var imageY: CGFloat = 0
        var facePathW: CGFloat = 0
        var facePathH: CGFloat = 0
        var image: UIImage?
        
        switch type {
        case .idcardFront:
            facePathW = isIPhone5or5cor5sorSE ? 95 : (isIPhone6or6sor7 ? 120 : 150)
            facePathH = facePathW * 0.812
            image = UIImage(contentsOfFile: resourceBundle().path(forResource: "idcard_avatar@2x", ofType: "png")!)
//            imageX = (kScreenW - facePathW) / 2
//            imageY = (kScreenH - facePathH) / 2 + idcardWindowLayer.frame.height / 2 - facePathW / 2 - 30
            imageX = (kScreenW - facePathW) / 2 + idcardWindowLayer.frame.width / 2 - facePathH / 2 - 25
            imageY = (kScreenH - facePathH) / 2 - idcardWindowLayer.frame.height / 2 + facePathW / 2 + 20
        case .idcardReverse:
            facePathW = isIPhone5or5cor5sorSE ? 40 : (isIPhone6or6sor7 ? 80 : 100)
            facePathH = facePathW
            image = UIImage(contentsOfFile: resourceBundle().path(forResource: "idcard_national@2x", ofType: "png")!)
            imageX = (kScreenW - facePathW) / 2 + idcardWindowLayer.frame.width / 2 - facePathH / 2 - 25
            imageY = (kScreenH - facePathH) / 2 - idcardWindowLayer.frame.height / 2 + facePathW / 2 + 20
        default: break
        }
        imageView.image = image
        imageView.frame = CGRect(x: imageX, y: imageY, width: facePathW, height: facePathH)
    }
    
    private func drawPath() {
        // 最里层镂空
        let transparentRoundedRectPath = UIBezierPath(roundedRect: idcardWindowLayer.frame,
                                                      cornerRadius: idcardWindowLayer.cornerRadius)
        // 最外层背景
        let path = UIBezierPath(rect: kBounds)
        path.append(transparentRoundedRectPath)
        path.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 0.6
        layer.addSublayer(fillLayer)
    }
}

// MARK: - Helpers
extension IdCardFloatingView {
    private func resourceBundle() -> Bundle {
        guard let path = Bundle(for: self.classForCoder).path(forResource: "CameraResource",
                                                              ofType: "bundle") else { return Bundle() }
        return Bundle(path: path)!
    }
}
