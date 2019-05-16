//
//  GenerateQRcodeViewController.swift
//  QRCode
//
//  Created by QDSG on 2019/5/16.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import CoreImage

class GenerateQRcodeViewController: UIViewController {
    
    @IBOutlet weak var qrcodeIconView: UIImageView!
    @IBOutlet weak var inputTextView: UITextView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1. 创建二维码滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults() // 恢复滤镜默认设置
        
        // 2. 设置滤镜输入数据
        // KVC
        let data = "123".data(using: .utf8)
        filter?.setValue(data, forKey: "inputMessage")
        
        // 3. 从二维码滤镜中, 获取结果图片
        var image = filter?.outputImage
        let transform = CGAffineTransform(scaleX: 20, y: 20)
        image = image?.transformed(by: transform)
        let resultImage = UIImage(ciImage: image!) // 图片处理
        print(resultImage.size)
        
        // 4. 显示图片
        qrcodeIconView.image = resultImage
    }
}
