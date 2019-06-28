//
//  TTPageTitleView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/28.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

open class TTPageTitleView: UIView {

    public weak var delegate: TTPageContentViewDelegate?
    
    public var currentIndex: Int
    
    public var style: TTPageStyle
    
    public var titles: [String]
    
    // MARK: - 初始化
    public init(frame: CGRect, style: TTPageStyle, titles: [String], currentIndex: Int) {
        self.style = style
        self.titles = titles
        self.currentIndex = currentIndex
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.style = TTPageStyle()
        self.titles = [String]()
        self.currentIndex = 0
        super.init(coder: aDecoder)
        setupUI()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = bounds
        
        layoutTitleLabel()
        layoutCoverView()
        layoutUnderline()
    }
    
    // MARK: - 私有
    private lazy var titleLabels = [UILabel]()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    private lazy var underline: UIView = {
        let view = UIView()
        view.backgroundColor = style.underlineColor
        view.layer.cornerRadius = style.underlineRadius
        return view
    }()
    
    private lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = style.coverViewColor
        view.alpha = style.coverViewAlpha
        return view
    }()
}

// MARK: - 设置UI属性
extension TTPageTitleView {
    private func setupUI() {
        addSubview(scrollView)
        
        scrollView.backgroundColor = style.titleViewBackgroundColor
        
        setupTitleLabel()
        
    }
    
    private func setupTitleLabel() {
        for (i, title) in titles.enumerated() {
            let label = UILabel()
            label.tag = i
            label.text = title
            label.textColor = i == currentIndex ? style.titleSelectedColor : style.titleNormalColor
            label.backgroundColor = i == currentIndex ? style.titleViewSelectedColor : .clear
            label.textAlignment = .center
            label.font = style.titleFont
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tappedTitleLabel(_:)))
            label.addGestureRecognizer(tap)
            scrollView.addSubview(label)
            
            titleLabels.append(label)
        }
    }
    
    private func layoutTitleLabel() {
        var x: CGFloat = 0
        let y: CGFloat = 0
        var width: CGFloat = 0
        let height: CGFloat = frame.size.height
        
        let count = titleLabels.count
        for (i, titleLabel) in titleLabels.enumerated() {
            if style.isTitleViewScrollEnabled {
                width = (titles[i] as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0),
                                                             options: .usesLineFragmentOrigin,
                                                             attributes: [NSAttributedString.Key.font: style.titleFont],
                                                             context: nil).width
                x = i == 0 ? style.titleMargin * 0.5 : (titleLabels[i - 1].frame.maxX + style.titleMargin)
            } else {
                width = bounds.width / CGFloat(count)
            }
            
            titleLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        }
        
        if style.isTitleScaleEnabled {
            titleLabels[currentIndex].transform = CGAffineTransform(scaleX: style.titleMaximumScaleFactor,
                                                                    y: style.titleMaximumScaleFactor)
        }
        
        if style.isTitleViewScrollEnabled {
            guard let titleLabel = titleLabels.last else { return }
            scrollView.contentSize.width = titleLabel.frame.maxX + style.titleMargin * 0.5
        }
    }
    
    private func layoutCoverView() {
        guard currentIndex < titleLabels.count else { return }
        let label = titleLabels[currentIndex]
        var width = label.bounds.width
        let height = style.coverViewHeight
        var x = label.frame.origin.x
        let y = (label.frame.height - height) * 0.5
        if style.isTitleViewScrollEnabled {
            x -= style.coverViewMargin
            width += 2 * style.coverViewMargin
        }
        coverView.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func layoutUnderline() {
        guard currentIndex < titleLabels.count else { return }
        let label = titleLabels[currentIndex]
        
        underline.frame.origin.x = label.frame.origin.x
        underline.frame.origin.y = bounds.height - style.underlineHeight
        underline.frame.size.width = label.frame.width
        underline.frame.size.height = style.underlineHeight
    }
}

extension TTPageTitleView {
    @objc private func tappedTitleLabel(_ tap: UITapGestureRecognizer) {
        
    }
}
