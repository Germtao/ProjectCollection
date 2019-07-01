//
//  TTPageViewProtocol.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/28.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

@objc public protocol TTPageEventHandleable: NSObjectProtocol {
    /// pageContentView 的上一页消失时, 上一页对应的controller调用
    @objc optional func contentViewDidDisappear()
    
    /// pageContentView 停止滚动时, 当前页对应的controller调用
    @objc optional func contentViewDidEndScroll()
    
    /// pageTitleView 重复点击调用
    @objc optional func titleViewDidRepeatClicked()
}

public protocol TTPageContentViewDelegate: NSObjectProtocol {
    func pageContentView(_ contentView: TTPageContentView, didEndScrollAt index: Int)
    func pageContentView(_ contentView: TTPageContentView, scrollingWith sourceIndex: Int, targetIndex: Int, progress: CGFloat)
}

@objc public protocol TTPageTitleViewDelegate: NSObjectProtocol {
    /// pageView事件回调处理者
    @objc optional var eventHandleable: TTPageEventHandleable? { get }
    
    func pageTitleView(_ titleView: TTPageTitleView, didSelectedAt index: Int)
}
