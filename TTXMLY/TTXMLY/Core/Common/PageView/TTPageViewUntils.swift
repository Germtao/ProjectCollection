//
//  TTPageViewUntils.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/1.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

typealias ColorRGB = (red: CGFloat, green: CGFloat, blue: CGFloat)

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    convenience init?(hex: String, alpha: CGFloat) {
        guard hex.count >= 6 else { return nil }
        
        var hexStr = hex.uppercased()
        
        if hexStr.hasPrefix("##") || hexStr.hasPrefix("0x") {
            hexStr = (hexStr as NSString).substring(from: 2)
        }
        
        if hexStr.hasPrefix("#") {
            hexStr = (hexStr as NSString).substring(from: 1)
        }
        
        var range = NSRange(location: 0, length: 2)
        let rStr = (hexStr as NSString).substring(with: range)
        range.location = 2
        let gStr = (hexStr as NSString).substring(with: range)
        range.location = 4
        let bStr = (hexStr as NSString).substring(with: range)
        
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
        self.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: alpha)
    }
    
    func getRGB() -> ColorRGB {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (red * 255, green * 255, blue * 255)
    }
}
