//
//  TTPageViewManager.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/1.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

// MARK: - 通过这个类创建的pageView，titleView和contentView的frame是不确定的，适合于titleView和contentView分开布局的情况
/// 需要给titleView和contentView布局，可以用frame或者Autolayout布局
open class TTPageViewManager: NSObject {
    private var style: TTPageStyle
    private var titles: [String]
    private var childViewControllers: [UIViewController]
    private var startIndex: Int
    
    private lazy var titleView = TTPageTitleView(frame: .zero,
                                                 style: style,
                                                 titles: titles,
                                                 currentIndex: startIndex)
    
    private lazy var contentView = TTPageContentView(frame: .zero,
                                                     style: style,
                                                     viewControllers: childViewControllers,
                                                     currentIndex: startIndex)
    
    public init(style: TTPageStyle,
                titles: [String],
                childViewControllers: [UIViewController],
                startIndex: Int = 0) {
        self.style = style
        self.titles = titles
        self.childViewControllers = childViewControllers
        self.startIndex = startIndex
        super.init()
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleView.delegate = contentView
        contentView.delegate = titleView
    }
}
