//
//  Utils.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/26.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

struct Size {
    static let screenW: CGFloat = UIScreen.main.bounds.width
    static let screenH: CGFloat = UIScreen.main.bounds.height
    static let navBarH: CGFloat = Size.specialScreen ? 88.0 : 64.0
    static let tabBarH: CGFloat = Size.specialScreen ? 83.0 : 49.0
    static let statusBarH: CGFloat = Size.specialScreen ? 44.0 : 20.0
    
    /// 是否为刘海屏
    static let specialScreen: Bool = Size.screenH >= 812.0 ? true : false
    
    static let defaultFontSize: CGFloat = 18.0
    
    // MARK: - 首页推荐
    static let newsCellMargin: CGFloat = 150.0
}

struct Color {
    static let defaultTitle = UIColor.black
    static let defaultBackground = UIColor.white
    static let line = UIColor(red: (218.0/255.0), green: (218.0/255.0), blue: (218.0/255.0), alpha: 1.0)
    static let navBarTint = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
    static let button = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
    static let buttonBg = UIColor(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)
    
    static let sectionFooter = UIColor(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)
    
    static let endLabel = UIColor(red: 248, green: 210, blue: 74, alpha: 1)
    
    static let categoryCell = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)
    
    static let vipFreeBg = UIColor(red: 203/255.0, green: 148/255.0, blue: 95/255.0, alpha: 1)
}

struct TTFont {
    static func font(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
}

struct Utils {
    /// 获取分类id
    static func getCategoryId(from url: String, key: String) -> String {
        // 判断是否有参数
        if !url.contains("?") { return "" }
        
        var paras = [String: Any]()
        // 截取参数
        let parasStr = url.split(separator: "?")[1]
        
        // 判断参数是单个还是多个
        if parasStr.contains("&") { // 多个
            let urlCompontents = parasStr.split(separator: "&")
            for keyValue in urlCompontents {
                let compontents = keyValue.split(separator: "=")
                let key = String(compontents[0])
                let value = String(compontents[1])
                paras[key] = value
            }
        } else { // 单个
            let compontents = parasStr.split(separator: "=")
            if compontents.count == 1 { return "nil" }
            let key = String(compontents[0])
            let value = String(compontents[1])
            paras[key] = value
        }
        
        return paras[key] as! String
    }
}
