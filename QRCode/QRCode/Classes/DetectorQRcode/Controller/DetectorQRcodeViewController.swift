//
//  DetectorQRcodeViewController.swift
//  QRCode
//
//  Created by QDSG on 2019/5/16.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class DetectorQRcodeViewController: UIViewController {
    
    @IBOutlet weak var sourceIconView: UIImageView!
    
    @IBAction func detectorQRCode() {
        
        // 获取需要识别的图片
        guard let sourceImage = sourceIconView.image, let ciimage = CIImage(image: sourceImage) else {
            fatalError("no value of image.")
        }
        
        // 开始识别
        // 1. 创建一个二维码探测器
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                                        context: nil,
                                        options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]) else {
            fatalError("no value of CIDetector.")
        }
        
        var results = [String]()
        // 2. 直接探测二维码特征
        let features = detector.features(in: ciimage)
        for feature in features {
            let qrFeature =  feature as! CIQRCodeFeature
//            print(qrFeature.messageString ?? "no message")
//            print(qrFeature.bounds)
            results.append(qrFeature.messageString!)
            
            let resultImage = drawFrame(sourceImage: sourceImage, feature: qrFeature)
            sourceIconView.image = resultImage
        }
        
        let alertVC = UIAlertController(title: "结果", message: results.description, preferredStyle: .alert)
        let action = UIAlertAction(title: "关闭", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}

extension DetectorQRcodeViewController {
    /// 绘制识别区
    private func drawFrame(sourceImage: UIImage, feature: CIQRCodeFeature) -> UIImage? {
        let size = sourceImage.size
        
        // 1. 开启图形上下文
        UIGraphicsBeginImageContext(size)
        
        // 2. 绘制大图片
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // 坐标系转换（上下颠倒）
        let context = UIGraphicsGetCurrentContext()
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -size.height)
        
        // 3. 绘制路径
        let bounds = feature.bounds
        let path = UIBezierPath(rect: bounds)
        UIColor.red.setStroke()
        path.lineWidth = 6
        path.stroke()
        
        // 4. 取出结果图片
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 5. 关闭上下文
        UIGraphicsEndImageContext()
        
        return resultImage
    }
}
