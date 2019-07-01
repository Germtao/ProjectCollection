//
//  TTPageView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/1.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

// MARK: - 通过这个类创建的pageView，默认titleView和contentView连在一起，效果类似于网易新闻
/// 只能纯代码创建，不能在xib或者storyboard里面使用
open class TTPageView: UIView {

    private var style: TTPageStyle
    private var titles: [String]
    private var childViewControllers: [UIViewController]
    private var startIndex: Int
    
    private(set) public lazy var titleView = TTPageTitleView(frame: .zero,
                                                             style: style,
                                                             titles: titles,
                                                             currentIndex: startIndex)
    
    private(set) public lazy var contentView = TTPageContentView(frame: .zero,
                                                                 style: style,
                                                                 viewControllers: childViewControllers,
                                                                 currentIndex: startIndex)
    
    public init(frame: CGRect,
                style: TTPageStyle,
                titles: [String],
                childViewControllers: [UIViewController],
                startIndex: Int = 0) {
        self.style = style
        self.titles = titles
        self.childViewControllers = childViewControllers
        self.startIndex = startIndex
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let titleFrame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleViewHeight)
        titleView.frame = titleFrame
        addSubview(titleView)
        
        let contentFrame = CGRect(x: 0, y: style.titleViewHeight, width: bounds.width, height: bounds.height - style.titleViewHeight)
        contentView.frame = contentFrame
        addSubview(contentView)
        
        titleView.delegate = contentView
        contentView.delegate = titleView
    }
}
