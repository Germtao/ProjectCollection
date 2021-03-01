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
    
    // Executes a block of code, associated with a unique token, only once.
    // The code is thread safe and will only execute the code once even in the presence of multithreaded calls.
    public class func once(token: String, block: () -> Void) {
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
