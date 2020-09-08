//
//  CircleColorSparkView.swift
//  SparkForUIView
//
//  Created by QDSG on 2020/6/5.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

/// 为了创建火花视图，我们还需要一个工厂数据以填充，需要的数据是火花的大小，
/// 以及用来决定火花在哪个烟花的索引（用于增加随机性）
protocol SparkViewFactoryData {
    var size: CGSize { get }
    var index: Int { get }
}

protocol SparkViewFactory {
    func create(with data: SparkViewFactoryData) -> SparkView
}

class CircleColorSparkViewFactory: SparkViewFactory {
    var colors: [UIColor] { return UIColor.sparkColorSet1 }
    
    func create(with data: SparkViewFactoryData) -> SparkView {
        let index = data.index % colors.count
        let color = colors[index]
        return CircleColorSparkView(color: color, size: data.size)
    }
}

class SparkView: UIView {}

class CircleColorSparkView: SparkView {
    
    init(color: UIColor, size: CGSize) {
        super.init(frame: CGRect(origin: .zero, size: size))
        backgroundColor = color
        layer.cornerRadius = frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 你看这样抽象了之后，就算再实现一个像胖吉猫的火花也会很简单。接下来让我们来创建经典烟花。
typealias FireworkSpark = (sparkView: SparkView, trajectory: SparkTrajectory)

protocol Firework {
    /// 烟花的初始位置
    var origin: CGPoint { get set }
    
    /// 定义了轨迹的大小. 轨迹都是统一大小
    /// 所以需要在展示到屏幕上前将其放大
    var scale: CGFloat { get set }
    
    /// 火花的大小
    var sparkSize: CGSize { get set }
    
    /// 获取轨迹
    var trajectoryFactory: SparkTrajectoryFactory { get }
    
    /// 获取火花视图
    var sparkViewFactory: SparkViewFactory { get }
    
    func sparkViewFactoryData(at index: Int) -> SparkViewFactoryData
    func sparkView(at index: Int) -> SparkView
    func trajectory(at index: Int) -> SparkTrajectory
}

extension Firework {
    /// 帮助方法，用于返回火花视图及对应的轨迹
    func spark(at index: Int) -> FireworkSpark {
        return FireworkSpark(self.sparkView(at: index), self.trajectory(at: index))
    }
}


// MARK: - UIColor
extension UIColor {
    static var sparkColorSet1: [UIColor] {
        return [
            UIColor(red: 0.89, green: 0.58, blue: 0.70, alpha: 1.00),
            UIColor(red: 0.96, green: 0.87, blue: 0.62, alpha: 1.00),
            UIColor(red: 0.67, green: 0.82, blue: 0.94, alpha: 1.00),
            UIColor(red: 0.54, green: 0.56, blue: 0.94, alpha: 1.00)
        ]
    }
}
