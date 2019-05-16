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
        
        // 2. 直接探测二维码特征
        let features = detector.features(in: ciimage)
        for feature in features {
            let qrFeature =  feature as! CIQRCodeFeature
            print(qrFeature.messageString ?? "no message")
            print(qrFeature.bounds)
        }
    }
}
