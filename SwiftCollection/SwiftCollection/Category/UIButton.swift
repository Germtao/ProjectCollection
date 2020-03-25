//
//  UIButton.swift
//  SwiftCollection
//
//  Created by QDSG on 2020/3/24.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

/**
 UIButton防止重复点击, 实现思路:
 
 1. 定义一个属性关联的结构体，结构体中定义点击间隔和是否可点击两个属性
 2. 使用Runtime关联属性
 3. 实现方法交换
 4. Swift 4.0中initialize()已经被废弃 所以需要自定义一个initializeMethod方法，并在Appdelegate中调用
 */

extension UIButton {
    private struct AssociatedKeys {
        static var eventInterval = "eventInterval"
        static var eventUnavailable = "eventUnavailable"
    }
    
    /// 重复点击的时间
    var eventInterval: TimeInterval {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventInterval, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let interval = objc_getAssociatedObject(self, &AssociatedKeys.eventInterval) as? TimeInterval {
                return interval
            }
            return 1.0
        }
    }
    
    /// 是否可点击
    var eventUnavailable: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventUnavailable, newValue as Bool, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let enable = objc_getAssociatedObject(self, &AssociatedKeys.eventUnavailable) as? Bool {
                return enable
            }
            return false
        }
    }
    
    /// 新建初始化方法, 在这个方法中实现在运行时方法替换
    class func initializeMethod() {
        let selector = #selector(sendAction(_:to:for:))
        let newSelector = #selector(tt_sendAction(_:to:for:))
        
        let method = class_getInstanceMethod(self, selector)!
        let newMethod = class_getInstanceMethod(self, newSelector)!
        
        let add = class_addMethod(self, selector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))
        if add {
            class_replaceMethod(self, newSelector, method_getImplementation(method), method_getTypeEncoding(method))
        } else {
            method_exchangeImplementations(method, newMethod)
        }
    }
    
    @objc private func tt_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        if !eventUnavailable {
            eventUnavailable.toggle()
            tt_sendAction(action, to: target, for: event)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + eventInterval) {
                self.eventUnavailable.toggle()
            }
        } else {
            print("点太快了")
        }
    }
}
