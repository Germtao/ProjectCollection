//
//  String.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/5.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Foundation

extension String {
    /// 数字转字符串
    static func transform(from count: Int) -> String {
        if count > 100000000 {
            return String(format: "%.1f亿", Double(count) / 100000000)
        } else if count > 10000 {
            return String(format: "%.1f万", Double(count) / 10000)
        } else {
            return "\(count)"
        }
    }
}
