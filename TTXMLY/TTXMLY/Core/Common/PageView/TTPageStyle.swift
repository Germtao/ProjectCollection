//
//  TTPageStyle.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/28.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

public struct TTPageStyle {
    // titleView
    public var titleViewHeight: CGFloat = 44.0
    public var titleNormalColor: UIColor = .black
    public var titleSelectedColor: UIColor = .blue
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 15)
    public var titleViewBackgroundColor: UIColor = .white
    public var titleMargin: CGFloat = 30.0
    public var titleViewSelectedColor: UIColor = .clear
    
    // titleView滑动
    public var isTitleViewScrollEnabled: Bool = false
    
    // titleView下划线
    public var isShowUnderline: Bool = false
    public var underlineColor: UIColor = .blue
    public var underlineHeight: CGFloat = 2.0
    public var underlineRadius: CGFloat = 1.0
    
    // 缩放
    public var isTitleScaleEnabled: Bool = false
    public var titleMaximumScaleFactor: CGFloat = 1.2
    
    // 遮罩
    public var isShowCoverView: Bool = false
    public var coverViewColor: UIColor = .black
    public var coverViewAlpha: CGFloat = 0.4
    public var coverViewMargin: CGFloat = 8.0
    public var coverViewHeight: CGFloat = 25.0
    public var coverViewRadius: CGFloat = 12.0
    
    // contentView
    public var isContentViewScrollEnabled: Bool = false
    public var contentViewColor: UIColor = .white
}
