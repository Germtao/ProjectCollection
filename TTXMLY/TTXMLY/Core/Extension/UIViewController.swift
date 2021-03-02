//
//  UIViewController.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/26.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

extension UIViewController: TTAwakeProtocol {
    private struct AssociatedKeys {
        
        static var pushToCurrentVcFinished: Bool = false
        static var PushToNextVcFinished: Bool = false
        
        static var navBarBackgroundImage: UIImage = UIImage()
        
        static var navBarTintColor: UIColor = TTNavigationBar.defaultNavBarTintColor
        static var navBarBarTintColor: UIColor = TTNavigationBar.defaultNavBarBarTintColor
        static var navBarTitleColor: UIColor = TTNavigationBar.defaultNavBarTitleColor
        static var navBarBackgroundAlpha: CGFloat = TTNavigationBar.defaultBackgroundAlpha
        static var statusBarStyle: UIStatusBarStyle = TTNavigationBar.defaultStatusBarStyle
        static var navBarShadowImageHidden: Bool = false
        
        static var customNavBar = UINavigationBar()
    }
    
    /// fromVc 推送到 currentVc 之前，currentVc 无法更改 navigationBar barTintColor
    var pushToCurrentVcFinished: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.pushToCurrentVcFinished, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            guard let finished = objc_getAssociatedObject(self, &AssociatedKeys.pushToCurrentVcFinished) as? Bool else {
                return false
            }
            return finished
        }
    }
    
    private var pushToNextVcFinished: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.PushToNextVcFinished, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            guard let finished = objc_getAssociatedObject(self, &AssociatedKeys.PushToNextVcFinished) as? Bool else {
                return false
            }
            return finished
        }
    }
    
    /// set navigationBar backgroundImage
    var navBarBackgroundImage: UIImage? {
        guard let image = objc_getAssociatedObject(self, &AssociatedKeys.navBarBackgroundImage) as? UIImage else {
            return TTNavigationBar.defaultNavBarBackgroundImage
        }
        return image
    }
    
    /// navBar barTintColor
    var navBarBarTintColor: UIColor {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.navBarBarTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if !customNavBar.isKind(of: UINavigationBar.self) {
                if canUpdateNavBarBarTintColorOrBackgroundAlpha {
                    navigationController?.setNeedsNavigationBarUpdate(barTintColor: newValue)
                }
            }
        }
        get {
            guard let color = objc_getAssociatedObject(self, &AssociatedKeys.navBarBarTintColor) as? UIColor else {
                return TTNavigationBar.defaultNavBarBarTintColor
            }
            return color
        }
    }
    
    /// navigationBar _UIBarBackground alpha
    var navBarBackgroundAlpha: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.navBarBackgroundAlpha, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if !customNavBar.isKind(of: UINavigationBar.self) {
                if canUpdateNavBarBarTintColorOrBackgroundAlpha {
                    navigationController?.setNeedsNavigationBarUpdate(barBackgroundAlpha: newValue)
                }
            }
        }
        get {
            guard let alpha = objc_getAssociatedObject(self, &AssociatedKeys.navBarBackgroundAlpha) as? CGFloat else {
                return 1.0
            }
            return alpha
        }
    }
    
    /// navigationBar tintColor
    var navBarTintColor: UIColor {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.navBarTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if !customNavBar.isKind(of: UINavigationBar.self) {
                if !pushToNextVcFinished {
                    navigationController?.setNeedsNavigationBarUpdate(tintColor: newValue)
                }
            }
        }
        get {
            guard let color = objc_getAssociatedObject(self, &AssociatedKeys.navBarTintColor) as? UIColor else {
                return TTNavigationBar.defaultNavBarTintColor
            }
            return color
        }
    }
    
    /// navigationBar titleColor
    var navBarTitleColor: UIColor {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.navBarTitleColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if !customNavBar.isKind(of: UINavigationBar.self) {
                if !pushToNextVcFinished {
                    navigationController?.setNeedsNavigationBarUpdate(titleColor: newValue)
                }
            }
        }
        get {
            guard let color = objc_getAssociatedObject(self, &AssociatedKeys.navBarTitleColor) as? UIColor else {
                return TTNavigationBar.defaultNavBarTitleColor
            }
            return color
        }
    }
    
    /// statusBarStyle
    var statusBarStyle: UIStatusBarStyle {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.statusBarStyle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setNeedsStatusBarAppearanceUpdate()
        }
        get {
            guard let style = objc_getAssociatedObject(self, &AssociatedKeys.statusBarStyle) as? UIStatusBarStyle else {
                return TTNavigationBar.defaultStatusBarStyle
            }
            return style
        }
    }
    
    /// 如果要隐藏 shadowImage，可以通过 hideShadowImage = true
    var navBarShadowImageHidden: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.navBarShadowImageHidden, newValue, .OBJC_ASSOCIATION_ASSIGN)
            navigationController?.setNeedsNavigationBarUpdate(hideShadowImage: newValue)
        }
        get {
            guard let hidden = objc_getAssociatedObject(self, &AssociatedKeys.navBarShadowImageHidden) as? Bool else {
                return TTNavigationBar.defaultShadowImageHidden
            }
            return hidden
        }
    }
    
    var customNavBar: UIView {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.customNavBar, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let navBar = objc_getAssociatedObject(self, &AssociatedKeys.customNavBar) as? UINavigationBar else {
                return UIView()
            }
            return navBar
        }
    }
    
    private var canUpdateNavBarBarTintColorOrBackgroundAlpha: Bool {
        let isRootViewController = navigationController?.viewControllers.first == self
        if (pushToCurrentVcFinished || isRootViewController) && !pushToNextVcFinished {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - swizzling two system methods: viewWillAppear(_:) and viewWillDisappear(_:)
    
    private static let onceToken = UUID().uuidString
    static func awake() {
        DispatchQueue.once(token: onceToken) {
            let needSwizzlingSelectors = [
                #selector(viewWillAppear(_:)),
                #selector(viewWillDisappear(_:)),
                #selector(viewDidAppear(_:))
            ]
            
            for selector in needSwizzlingSelectors {
                let newSelectorStr = "tt_" + selector.description
                if let originalMethod = class_getInstanceMethod(self, selector),
                    let swizzlingMethod = class_getInstanceMethod(self, Selector(newSelectorStr)) {
                    method_exchangeImplementations(originalMethod, swizzlingMethod)
                }
            }
        }
    }
    
    @objc func tt_viewWillAppear(_ animated: Bool) {
        if canUpdateNavBar {
            pushToNextVcFinished = false
            navigationController?.setNeedsNavigationBarUpdate(tintColor: navBarTintColor)
            navigationController?.setNeedsNavigationBarUpdate(titleColor: navBarTitleColor)
        }
        tt_viewWillAppear(animated)
    }
    
    @objc func tt_viewWillDisappear(_ animated: Bool) {
        if canUpdateNavBar {
            pushToNextVcFinished = true
        }
        tt_viewWillDisappear(animated)
    }
    
    @objc func tt_viewDidAppear(_ animated: Bool) {
        if navigationController?.viewControllers.first != self {
            pushToCurrentVcFinished = true
        }
        
        if canUpdateNavBar {
            if let navBarBgImage = navBarBackgroundImage {
                navigationController?.setNeedsNavigationBarUpdate(backgroundImage: navBarBgImage)
            } else {
                navigationController?.setNeedsNavigationBarUpdate(barTintColor: navBarBarTintColor)
            }
            navigationController?.setNeedsNavigationBarUpdate(tintColor: navBarTintColor)
            navigationController?.setNeedsNavigationBarUpdate(titleColor: navBarTitleColor)
            navigationController?.setNeedsNavigationBarUpdate(barBackgroundAlpha: navBarBackgroundAlpha)
            navigationController?.setNeedsNavigationBarUpdate(hideShadowImage: navBarShadowImageHidden)
        }
        tt_viewDidAppear(animated)
    }
    
    private var canUpdateNavBar: Bool {
        let viewFrame = view.frame
        let maxFrame = UIScreen.main.bounds
        let middleFrame = CGRect(x: 0, y: Constants.Sizes.navBarH, width: Constants.Sizes.screenW, height: Constants.Sizes.screenH - Constants.Sizes.navBarH)
        let minFrame = CGRect(x: 0, y: Constants.Sizes.navBarH, width: Constants.Sizes.screenW, height: Constants.Sizes.screenH - Constants.Sizes.navBarH - Constants.Sizes.tabBarH)
        // 蝙蝠🦇
        let isBat = viewFrame.equalTo(maxFrame) || viewFrame.equalTo(middleFrame) || viewFrame.equalTo(minFrame)
        
        return navigationController != nil && isBat
    }
}

// MARK: - Router
extension UIViewController {
    /// 从页面B 弹出到 页面A
    func tt_toLastViewController(_ animated: Bool) {
        if navigationController != nil {
            if navigationController?.viewControllers.count == 1 {
                dismiss(animated: animated, completion: nil)
            } else {
                navigationController?.popViewController(animated: animated)
            }
        } else if presentingViewController != nil {
            dismiss(animated: animated, completion: nil)
        }
    }
    
    class func tt_currentViewController() -> UIViewController {
        if let rootVc = UIApplication.shared.keyWindow?.rootViewController {
            return tt_currentViewController(from: rootVc)
        } else {
            return UIViewController()
        }
    }
    
    static var currentVC: UIViewController {
        if let rootVc = UIApplication.shared.keyWindow?.rootViewController {
            return tt_currentViewController(from: rootVc)
        } else {
            return UIViewController()
        }
    }
    
    class func tt_currentViewController(from fromVc: UIViewController) -> UIViewController {
        if fromVc.isKind(of: UINavigationController.self) {
            let navController = fromVc as! UINavigationController
            return tt_currentViewController(from: navController.viewControllers.last!)
        } else if fromVc.isKind(of: UITabBarController.self) {
            let tabBarControlelr = fromVc as! UITabBarController
            return tt_currentViewController(from: tabBarControlelr.selectedViewController!)
        } else if fromVc.presentedViewController != nil {
            return tt_currentViewController(from: fromVc.presentingViewController!)
        } else {
            return fromVc
        }
    }
}
