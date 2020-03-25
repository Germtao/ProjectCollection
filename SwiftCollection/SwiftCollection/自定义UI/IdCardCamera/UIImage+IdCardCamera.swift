//
//  UIImage+IdCardCamera.swift
//  SwiftCollection
//
//  Created by QDSG on 2020/3/25.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

extension UIImage {
    func idcard_clipImage(inRect rect: CGRect) -> UIImage? {
        let scale_w = self.size.width / kScreenW
        let scale_h = self.size.height / kScreenH
        
        // 其实是横屏的
        let origin_w = rect.size.width
        let origin_h = rect.size.height
        
        let x = (kScreenH - origin_h) / 2 * scale_h
        let y = (kScreenW - origin_w) / 2 * scale_w
        let w = origin_h * scale_h
        let h = origin_w * scale_w
        let r = CGRect(x: x, y: y, width: w, height: h)
        
        guard let cgImage = self.cgImage?.cropping(to: r) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}
