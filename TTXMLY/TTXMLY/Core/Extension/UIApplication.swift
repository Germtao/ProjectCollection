//
//  UIApplication.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/26.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

// MARK: - 2. 让 App 启动时只执行一次 harmless 方法
extension UIApplication {
    /// 使用静态属性以保证只调用一次(该属性是个方法)
    private static let runOnce: Void = {
        TTNothingToSeeHere.harmless()
    }()
    
    /// 重写next属性
    open override var next: UIResponder? {
        UIApplication.runOnce
        return super.next
    }
}

// MARK: - 3. 自定义类实现 TTAwakeProtocol 协议，重写 awake 方法
// MARK: -    自定义类实现 TTFatherAwakeProtocol 协议，重写 fatherAwake 方法
