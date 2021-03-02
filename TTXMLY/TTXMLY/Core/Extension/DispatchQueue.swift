//
//  DispatchQueue.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/26.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Foundation

// MARK: - Swizzling会改变全局状态,所以用 DispatchQueue.once 来确保无论多少线程都只会被执行一次
extension DispatchQueue {
    private static var onceTracker = [String]()
    
    /// 仅执行一次与唯一 token 关联的代码块
    /// 该代码是线程安全的，即使存在多线程调用，也只会执行一次代码
    public class func once(token: String, block: () -> Void) {
        // 保证被 objc_sync_enter 和 objc_sync_exit 包裹的代码可以有序同步地执行
        objc_sync_enter(self)
        // 作用域结束后执行defer中代码
        defer {
            objc_sync_exit(self)
        }
        
        if onceTracker.contains(token) { return }
        
        onceTracker.append(token)
        block()
    }
}
