//
//  UIButton+Layout.swift
//  TumblrMenu
//
//  Created by TT on 2020/5/16.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

enum ButtonImageStyle: Int {
    case imageTop
    case imageLeft
    case imageRight
    case imageBottom
}

extension UIButton {
    /// 布局按钮
    func layoutButton(with style: ButtonImageStyle, space: CGFloat = 4) {
        let imageWidth = imageView!.frame.width
        let imageHeight = imageView!.frame.height
        let titleWidth = titleLabel!.frame.width
        let titleHeight = titleLabel!.frame.height
        
        // 初始化内边距
        var imageInsets = UIEdgeInsets.zero
        var titleInsets = UIEdgeInsets.zero
        
        switch style {
        case .imageTop:
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: titleHeight + space / 2, right: -titleWidth)
            titleInsets = UIEdgeInsets(top: imageHeight + space / 2, left: -imageWidth, bottom: 0, right: 0)
        case .imageLeft:
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: space / 2)
            titleInsets = UIEdgeInsets(top: 0, left: space / 2, bottom: 0, right: 0)
        case .imageRight:
            imageInsets = UIEdgeInsets(top: 0, left: titleWidth + space / 2, bottom: 0, right: -titleWidth)
            titleInsets = UIEdgeInsets(top: 0, left: -imageWidth - space / 2, bottom: 0, right: imageWidth)
        case .imageBottom:
            imageInsets = UIEdgeInsets(top: titleHeight + space / 2, left: 0, bottom: 0, right: -titleWidth)
            titleInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: imageHeight + space / 2, right: 0)
        }
        
        self.imageEdgeInsets = imageInsets
        self.titleEdgeInsets = titleInsets
    }
}

// MARK: - 按钮重复点击处理
extension UIButton {
    
    private struct AssociatedKeys {
        static var eventInterval = "eventInterval"
        static var eventUnavailable = "eventUnavailable"
    }
    
    /// 重复点击的时间 属性设置
    var eventInterval: TimeInterval {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventInterval, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let interval = objc_getAssociatedObject(self, &AssociatedKeys.eventInterval) as? TimeInterval {
                return interval
            }
            return 0.5
        }
    }
    
    /// 按钮不可点 属性设置
    private var eventUnavailable: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventUnavailable, newValue as Bool, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let unavailable = objc_getAssociatedObject(self, &AssociatedKeys.eventUnavailable) as? Bool {
                return unavailable
            }
            return false
        }
    }
    
    /// 新建初始化方法,在这个方法中实现在运行时方法替换
    class func initializeMethod() {
        let selector = #selector(UIButton.sendAction(_:to:for:))
        let newSelector = #selector(new_sendAction(_:to:for:))
        
        let method = class_getInstanceMethod(self, selector)!
        let newMethod = class_getInstanceMethod(self, newSelector)!
        
        if class_addMethod(self, selector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)) {
            class_replaceMethod(self, newSelector, method_getImplementation(method), method_getTypeEncoding(method))
        } else {
            method_exchangeImplementations(method, newMethod)
        }
    }
    
    /// 在这个方法中
    @objc private func new_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        if eventUnavailable == false {
            eventUnavailable = true
            new_sendAction(action, to: target, for: event)
            // 延时
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + eventInterval, execute: {
                self.eventUnavailable = false
            })
        }
    }
}
