//
//  TTPageTitleView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/28.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

public typealias TTTitleViewClikedHandler = (TTPageTitleView, Int) -> Void

open class TTPageTitleView: UIView {

    public weak var delegate: TTPageTitleViewDelegate?
    
    /// 点击标题时, 回调
    public var clickedHandler: TTTitleViewClikedHandler?
    
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
    
    private lazy var normalRGB = self.style.titleNormalColor.getRGB()
    private lazy var selectRGB = self.style.titleSelectedColor.getRGB()
    private lazy var detalRGB: ColorRGB = {
        let r = self.selectRGB.red - self.normalRGB.red
        let g = self.selectRGB.green - self.normalRGB.green
        let b = self.selectRGB.blue - self.normalRGB.blue
        return (r, g, b)
    }()
}

// MARK: - 设置UI属性和布局
extension TTPageTitleView {
    private func setupUI() {
        addSubview(scrollView)
        
        scrollView.backgroundColor = style.titleViewBackgroundColor
        
        setupTitleLabel()
        setupUnderline()
        setupCoverView()
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
    
    private func setupUnderline() {
        guard style.isShowUnderline else { return }
        scrollView.addSubview(underline)
    }
    
    private func setupCoverView() {
        guard style.isShowCoverView else { return }
        scrollView.insertSubview(coverView, at: 0)
        coverView.layer.cornerRadius = style.coverViewRadius
        coverView.layer.masksToBounds = true
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
        guard let index = tap.view?.tag else { return }
        selectedTitle(at: index)
    }
}

extension TTPageTitleView {
    public func selectedTitle(at index: Int) {
        if index > titles.count || index < 0 {
            print("TTPageTitleView - selctedTitle: 数组越界...")
        }
        
        // block回调
        clickedHandler?(self, index)
        
        if index == currentIndex {
            delegate?.eventHandleable??.titleViewDidRepeatClicked?()
            return
        }
        
        let sourceLabel = titleLabels[currentIndex]
        let targetLabel = titleLabels[index]
        
        sourceLabel.textColor = style.titleNormalColor
        targetLabel.textColor = style.titleSelectedColor
        
        delegate?.eventHandleable??.contentViewDidDisappear?()
        
        currentIndex = index
        
        // 代理回调
        delegate?.pageTitleView(self, didSelectedAt: currentIndex)
        
        adjustLabelPosition(targetLabel)
        
        if style.isTitleScaleEnabled {
            UIView.animate(withDuration: 0.25) {
                sourceLabel.transform = CGAffineTransform.identity
                targetLabel.transform = CGAffineTransform(scaleX: self.style.titleMaximumScaleFactor,
                                                          y: self.style.titleMaximumScaleFactor)
            }
        }
        
        if style.isShowUnderline {
            UIView.animate(withDuration: 0.25) {
                self.underline.frame.origin.x = targetLabel.frame.origin.x
                self.underline.frame.size.width = targetLabel.frame.width
            }
        }
        
        if style.isShowCoverView {
            let x = style.isTitleViewScrollEnabled ? (targetLabel.frame.origin.x - style.coverViewMargin) : targetLabel.frame.origin.x
            let width = style.isTitleViewScrollEnabled ? (targetLabel.frame.width + style.coverViewMargin * 2) : targetLabel.frame.width
            UIView.animate(withDuration: 0.25) {
                self.coverView.frame.origin.x = x
                self.coverView.frame.size.width = width
            }
        }
    }
    
    private func adjustLabelPosition(_ targetLabel: UILabel) {
        guard style.isTitleViewScrollEnabled,
            scrollView.contentSize.width > scrollView.bounds.width else {
            return
        }
        
        var offsetX = targetLabel.center.x - bounds.width * 0.5
        if offsetX < 0 { offsetX = 0 }
        
        if offsetX > scrollView.contentSize.width - scrollView.bounds.width {
            offsetX = scrollView.contentSize.width - scrollView.bounds.width
        }
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    private func fixUI(_ targetLabel: UILabel) {
        UIView.animate(withDuration: 0.05) {
            targetLabel.textColor = self.style.titleSelectedColor
            
            if self.style.isTitleScaleEnabled {
                targetLabel.transform = CGAffineTransform(scaleX: self.style.titleMaximumScaleFactor,
                                                          y: self.style.titleMaximumScaleFactor)
            }
            
            if self.style.isShowUnderline {
                self.underline.frame.origin.x = targetLabel.frame.origin.x
                self.underline.frame.size.width = targetLabel.frame.width
            }
            
            if self.style.isShowCoverView {
                self.coverView.frame.origin.x = self.style.isTitleViewScrollEnabled ? (targetLabel.frame.origin.x - self.style.coverViewMargin * 2) : targetLabel.frame.origin.x
                self.coverView.frame.size.width = self.style.isTitleViewScrollEnabled ? (targetLabel.frame.width + self.style.coverViewMargin * 2) : targetLabel.frame.width
            }
        }
    }
}

extension TTPageTitleView: TTPageContentViewDelegate {
    public func pageContentView(_ contentView: TTPageContentView, didEndScrollAt index: Int) {
        let sourceLabel = titleLabels[currentIndex]
        let targetLabel = titleLabels[index]
        
        sourceLabel.backgroundColor = .clear
        targetLabel.backgroundColor = style.titleViewSelectedColor
        
        currentIndex = index
        
        adjustLabelPosition(targetLabel)
        fixUI(targetLabel)
    }
    
    public func pageContentView(_ contentView: TTPageContentView, scrollingWith sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        if sourceIndex >= titleLabels.count || sourceIndex < 0 { return }
        if targetIndex >= titleLabels.count || targetIndex < 0 { return }
        
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        sourceLabel.textColor = UIColor(r: selectRGB.red - progress * detalRGB.red,
                                        g: selectRGB.green - progress * detalRGB.green,
                                        b: selectRGB.blue - progress * detalRGB.blue)
        targetLabel.textColor = UIColor(r: normalRGB.red + progress * detalRGB.red,
                                        g: normalRGB.green + progress * detalRGB.green,
                                        b: normalRGB.blue + progress * detalRGB.blue)
        
        if style.isTitleScaleEnabled {
            let detalScale = style.titleMaximumScaleFactor - 1.0
            sourceLabel.transform = CGAffineTransform(scaleX: style.titleMaximumScaleFactor - progress * detalScale,
                                                      y: style.titleMaximumScaleFactor - progress * detalScale)
            targetLabel.transform = CGAffineTransform(scaleX: 1.0 + progress * detalScale,
                                                      y: 1.0 + progress * detalScale)
        }
        
        if style.isShowUnderline {
            let detalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
            let detalW = targetLabel.frame.width - sourceLabel.frame.width
            underline.frame.origin.x = sourceLabel.frame.origin.x + progress * detalX
            underline.frame.size.width = sourceLabel.frame.width + progress * detalW
        }
        
        if style.isShowCoverView {
            let detalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
            let detalW = targetLabel.frame.width - sourceLabel.frame.width
            coverView.frame.origin.x = style.isTitleViewScrollEnabled ? (sourceLabel.frame.origin.x - style.coverViewMargin + detalX * progress) : (sourceLabel.frame.origin.x + detalX * progress)
            coverView.frame.size.width = style.isTitleViewScrollEnabled ? (sourceLabel.frame.width + style.coverViewMargin * 2 + detalW * progress) : (sourceLabel.frame.width + detalW * progress)
        }
    }
}
