//
//  TTNavigationBar.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/26.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTNavigationBar {
    private struct AssociatedKeys {
        static var defaultBarTintColor: UIColor = UIColor.white
        static var defaultBarBackgroundImage: UIImage = UIImage()
        static var defaultTintColor: UIColor = UIColor(red: 0, green: 0, blue: 0.478431, alpha: 1)
        static var defaultBarTitleColor: UIColor = UIColor.black
        static var defaultStatusBarStyle: UIStatusBarStyle = .default
        static var defaultShadowImageHidden: Bool = false
    }
    
    class var defaultBarTintColor: UIColor {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.defaultBarTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let color = objc_getAssociatedObject(self, &AssociatedKeys.defaultBarTintColor) as? UIColor else {
                return AssociatedKeys.defaultBarTintColor
            }
            return color
        }
    }
    
    class var defaultBarBackgroundImage: UIImage? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.defaultBarBackgroundImage, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let image = objc_getAssociatedObject(self, &AssociatedKeys.defaultBarBackgroundImage) as? UIImage else {
                return nil
            }
            return image
        }
    }
    
    class var defaultTintColor: UIColor {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.defaultTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let color = objc_getAssociatedObject(self, &AssociatedKeys.defaultTintColor) as? UIColor else {
                return AssociatedKeys.defaultTintColor
            }
            return color
        }
    }
    
    class var defaultBarTitleColor: UIColor {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.defaultBarTitleColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let color = objc_getAssociatedObject(self, &AssociatedKeys.defaultBarTitleColor) as? UIColor else {
                return AssociatedKeys.defaultBarTitleColor
            }
            return color
        }
    }
    
    class var defaultStatusBarStyle: UIStatusBarStyle {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.defaultStatusBarStyle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let style = objc_getAssociatedObject(self, &AssociatedKeys.defaultStatusBarStyle) as? UIStatusBarStyle else {
                return AssociatedKeys.defaultStatusBarStyle
            }
            return style
        }
    }
    
    class var defaultShadowImageHidden: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.defaultShadowImageHidden, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let hidden = objc_getAssociatedObject(self, &AssociatedKeys.defaultShadowImageHidden) as? Bool else {
                return AssociatedKeys.defaultShadowImageHidden
            }
            return hidden
        }
    }
    
    class var defaultBackgroundAlpha: CGFloat {
        return 1.0
    }
    
    /// 给定percent计算middleColor
    class func middleColor(from fromColor: UIColor, to toColor: UIColor, percent: CGFloat) -> UIColor {
        var fromRed: CGFloat = 0.0
        var fromGreen: CGFloat = 0.0
        var fromBlue: CGFloat = 0.0
        var fromAlpha: CGFloat = 0.0
        fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
        
        var toRed: CGFloat = 0.0
        var toGreen: CGFloat = 0.0
        var toBlue: CGFloat = 0.0
        var toAlpha: CGFloat = 0.0
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        
        let newRed = fromRed + (toRed - fromRed) * percent
        let newGreen = fromGreen + (toGreen - fromGreen) * percent
        let newBlue = fromBlue + (toBlue - fromBlue) * percent
        let newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent
        return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha)
    }
    
    /// 给定percent计算middleAlpha
    class func middleAlpha(from fromAlpha: CGFloat, to toAlpha: CGFloat, percent: CGFloat) -> CGFloat {
        let newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent
        return newAlpha
    }
}

// MARK: - /////////////////////////////////////////////////////////
// MARK: - 1. 定义 awakeProtocol 协议
protocol TTAwakeProtocol: NSObjectProtocol {
    static func awake()
}

protocol TTFatherAwakeProtocol: NSObjectProtocol {
    static func fatherAwake()
}

class TTNothingToSeeHere {
    static func harmless() {
        UINavigationBar.awake()
        UIViewController.awake()
        UINavigationController.fatherAwake()
    }
}
