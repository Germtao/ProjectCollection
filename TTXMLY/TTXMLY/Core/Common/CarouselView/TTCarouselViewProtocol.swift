//
//  TTCarouselViewProtocol.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/3.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Foundation

public protocol TTCarouselViewDataSource: NSObjectProtocol {
    func numberOfItems(in carouselView: TTCarouselView) -> Int
    
    func carouselView(_ carouselView: TTCarouselView, cellForItemAt index: Int) -> TTCarouselViewCell
}

@objc
public protocol TTCarouselViewDelegate: NSObjectProtocol {
    /// 是否高亮
    @objc optional func carouselView(_ carouselView: TTCarouselView, shouleHighlightItemAt index: Int) -> Bool
    
    /// 显示高亮
    @objc optional func carouselView(_ carouselView: TTCarouselView, didHighlightItemAt index: Int)
    
    /// 是否选中
    @objc optional func carouselView(_ carouselView: TTCarouselView, shouldSelectItemAt index: Int) -> Bool
    
    /// 选中
    @objc optional func carouselView(_ carouselView: TTCarouselView, didSelectItemAt index: Int)
    
    /// 即将显示
    @objc optional func carouselView(_ carouselView: TTCarouselView, willDisplay cell: TTCarouselViewCell, forItemAt index: Int)
    
    /// 即将结束显示
    @objc optional func carouselView(_ carouselView: TTCarouselView, didEndDisplaying cell: TTCarouselViewCell, forItemAt index: Int)
    
    /// 即将开始拖拽
    @objc optional func carouselViewWillBeginDragging(_ carouselView: TTCarouselView)
    
    /// 即将结束拖拽
    @objc optional func carouselViewWillEndDragging(_ carouselView: TTCarouselView, targetIndex: Int)
    
    /// 已经滑动
    @objc optional func carouselViewDidScroll(_ carouselView: TTCarouselView)
    
    /// 结束滑动
    @objc optional func carouselViewDidEndScrollAnmiation(_  carouselView: TTCarouselView)
    
    /// 已经结束滚动
    @objc optional func carouselViewDidEndDecelerating(_ carouselView: TTCarouselView)
}
