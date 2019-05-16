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
        
        if inputTextView.text.isEmpty { return }
        
        // 1. 创建二维码滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults() // 恢复滤镜默认设置
        
        // 2. 设置滤镜输入数据
        // KVC
        // 转成data
        let data = inputTextView.text.data(using: .utf8)
        filter?.setValue(data, forKey: "inputMessage")
        
        // 设置滤镜纠错率 - 字码可被修正  L - 7% M - 15% Q - 25% H - 30% 越高二维码越复杂
        filter?.setValue("M", forKey: "inputCorrectionLevel")
        
        // 3. 从二维码滤镜中, 获取结果图片
        var image = filter?.outputImage
        let transform = CGAffineTransform(scaleX: 20, y: 20)
        image = image?.transformed(by: transform)
        var resultImage = UIImage(ciImage: image!) // 图片处理
        print(resultImage.size)
        
        let centerImage = UIImage(named: "logo")
        if let image = getNewImage(sourceImage: resultImage, centerImage: centerImage!) {
            resultImage = image
        }
        
        // 4. 显示图片
        qrcodeIconView.image = resultImage
    }
}

// MARK: - Helper
extension GenerateQRcodeViewController {
    private func getNewImage(sourceImage: UIImage, centerImage: UIImage) -> UIImage? {
        let size = sourceImage.size
        
        // 1. 开启图形上下文
        UIGraphicsBeginImageContext(size)
        
        // 2. 绘制大图片
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // 3. 绘制小图片
        let width: CGFloat = 80
        let height: CGFloat = 80
        let x: CGFloat = (size.width - width) * 0.5
        let y: CGFloat = (size.height - height) * 0.5
        centerImage.draw(in: CGRect(x: x, y: y, width: width, height: height))
        
        // 4. 取出结果图片
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 5. 关闭上下文
        UIGraphicsEndImageContext()
        
        return resultImage
    }
}
