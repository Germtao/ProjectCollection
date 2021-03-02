//
//  UINavigationBar.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/26.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

extension UINavigationBar {
    private struct AssociatedKeys {
        static var backgroundView: UIView = UIView()
        static var backgroundImageView: UIImageView = UIImageView()
    }
    
    private var backgroundView: UIView? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.backgroundView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let bgView = objc_getAssociatedObject(self, &AssociatedKeys.backgroundView) as? UIView else {
                return nil
            }
            return bgView
        }
    }
    
    private var backgroundImageView: UIImageView? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.backgroundImageView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let bgImageView = objc_getAssociatedObject(self, &AssociatedKeys.backgroundImageView) as? UIImageView else {
                return nil
            }
            return bgImageView
        }
    }
    
    /// set navigationBar backgroundImage
    func tt_setBackgroundImage(image: UIImage) {
        backgroundView?.removeFromSuperview()
        backgroundView = nil
        if backgroundImageView == nil {
            setBackgroundImage(UIImage(), for: .default)
            backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: Constants.Sizes.navBarH))
            backgroundImageView?.autoresizingMask = .flexibleWidth
            subviews.first?.insertSubview(backgroundImageView ?? UIImageView(), at: 0)
        }
        backgroundImageView?.image = image
    }
    
    /// set navigationBar barTintColor
    func tt_setBackgroundColor(color: UIColor) {
        backgroundImageView?.removeFromSuperview()
        backgroundImageView = nil
        if backgroundView == nil {
            setBackgroundImage(UIImage(), for: .default)
            backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: Constants.Sizes.navBarH))
            backgroundView?.autoresizingMask = .flexibleWidth
            subviews.first?.insertSubview(backgroundView ?? UIView(), at: 0)
        }
        backgroundView?.backgroundColor = color
    }
    
    /// set _UIBarBackground alpha (_UIBarBackground subviews alpha <= _UIBarBackground alpha)
    func tt_setBackgroundAlpha(alpha: CGFloat) {
        if let backgroundView = subviews.first {
            if #available(iOS 11.0, *) {
                for view in backgroundView.subviews {
                    view.alpha = alpha
                }
            } else {
                backgroundView.alpha = alpha
            }
        }
    }
    
    /// 设置导航栏所有barButtonItem的 alpha
    func tt_setBarButtonItemsAlpha(alpha: CGFloat, hasSystemBackIndicator: Bool) {
        for view in subviews {
            if hasSystemBackIndicator {
                // UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
                if let _UIBarBackgroundClass = NSClassFromString("_UIBarBackground") {
                    if !view.isKind(of: _UIBarBackgroundClass) {
                        view.alpha = alpha
                    }
                }
                
                if let _UINavigationBarBackgroundClass = NSClassFromString("_UINavigationBarBackground") {
                    if !view.isKind(of: _UINavigationBarBackgroundClass) {
                        view.alpha = alpha
                    }
                }
            } else {
                // 这里如果不做判断的话，会显示 backIndicatorImage(系统返回按钮)
                if let _UINavigationBarBackIndicatorViewClass = NSClassFromString("_UINavigationBarBackIndicatorView"),
                    !view.isKind(of: _UINavigationBarBackIndicatorViewClass) {
                    if let _UIBarBackgroundClass = NSClassFromString("_UIBarBackground") {
                        if !view.isKind(of: _UIBarBackgroundClass) {
                            view.alpha = alpha
                        }
                    }
                    
                    if let _UINavigationBarBackground = NSClassFromString("_UINavigationBarBackground") {
                        if !view.isKind(of: _UINavigationBarBackground) {
                            view.alpha = alpha
                        }
                    }
                }
            }
        }
    }
    
    /// 设置导航栏在垂直方向上平移多少距离
    func tt_setTranslationY(y translationY: CGFloat) {
        transform = CGAffineTransform(translationX: 0, y: translationY)
    }
    
    func tt_getTranslationY() -> CGFloat {
        return transform.ty
    }
}

extension UINavigationBar: TTAwakeProtocol {
    // MARK: - call swizzling methods active 主动调用交换方法
    private static let onceToken = UUID().uuidString
    static func awake() {
        DispatchQueue.once(token: onceToken) {
            let needSwizzleSelectorArr = [#selector(setter: self.titleTextAttributes)]
            
            for selector in needSwizzleSelectorArr {
                let str = ("tt_" + selector.description)
                if let originalMethod = class_getInstanceMethod(self, selector),
                    let swizzledMethod = class_getInstanceMethod(self, Selector(str)) {
                    method_exchangeImplementations(originalMethod, swizzledMethod)
                }
            }
        }
    }
    
    // MARK: - swizzling pop
    @objc func tt_setTitleTextAttributes(_ newTitleTextAttributes: [String: Any]?) {
        guard var attributes = newTitleTextAttributes else { return }
        
        guard let originTitleAttributes = titleTextAttributes else {
            tt_setTitleTextAttributes(attributes)
            return
        }
        
        var titleColor: UIColor?
        for attribute in originTitleAttributes {
            if attribute.key == NSAttributedString.Key.foregroundColor {
                titleColor = attribute.value as? UIColor
                break
            }
        }
        
        guard let originTitleColor = titleColor else {
            tt_setTitleTextAttributes(attributes)
            return
        }
        
        if attributes[NSAttributedString.Key.foregroundColor.rawValue] == nil {
            attributes.updateValue(originTitleColor, forKey: NSAttributedString.Key.foregroundColor.rawValue)
        }
        
        tt_setTitleTextAttributes(attributes)
    }
}
