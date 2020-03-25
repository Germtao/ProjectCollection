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
    
    func fixImageOrientation() -> UIImage? {
        if self.imageOrientation == .up { return self }
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: .pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -(.pi / 2))
            break
        default:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1)
            break
        default:
            break
        }
        
        let ctx = CGContext(data: nil,
                            width: Int(size.width),
                            height: Int(size.height),
                            bitsPerComponent: self.cgImage!.bitsPerComponent,
                            bytesPerRow: 0,
                            space: self.cgImage!.colorSpace!,
                            bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
            break
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        guard let cgImg = ctx?.makeImage() else { return nil }
        return UIImage(cgImage: cgImg)
    }
}
