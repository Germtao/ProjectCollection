//
//  SparkTrajectory.swift
//  SparkForUIView
//
//  Created by QDSG on 2020/6/5.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

/// 用于表示火花轨迹的协议
protocol SparkTrajectory {
    /// 存储着定义轨迹所需要的所有的点
    var points: [CGPoint] { get set }
    
    /// 用 path 来表现轨迹
    var path: UIBezierPath { get }
}

extension SparkTrajectory {
    /// 缩放轨迹使其符合各种 UI 的要求
    /// 在各种形变和 shift: 之前使用
    func scale(by value: CGFloat) -> SparkTrajectory {
        var copy = self
        (0..<self.points.count).forEach { copy.points[$0]. }
    }
}

/// 拥有两个控制点的贝塞尔曲线
struct CubicBezierTrajectory: SparkTrajectory {
    
    var points = [CGPoint]()
    
    var path: UIBezierPath {
        guard points.count == 4 else { fatalError("4 points required") }
        
        let path = UIBezierPath()
        path.move(to: points[0])
        path.addCurve(to: points[3], controlPoint1: points[1], controlPoint2: points[2])
        return path
    }
    
    init(_ x0: CGFloat, _ y0: CGFloat,
         _ x1: CGFloat, _ y1: CGFloat,
         _ x2: CGFloat, _ y2: CGFloat,
         _ x3: CGFloat, _ y3: CGFloat) {
        points.append(CGPoint(x: x0, y: y0))
        points.append(CGPoint(x: x1, y: y1))
        points.append(CGPoint(x: x2, y: y2))
        points.append(CGPoint(x: x3, y: y3))
    }
    
}
