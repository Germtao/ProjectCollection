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
}
