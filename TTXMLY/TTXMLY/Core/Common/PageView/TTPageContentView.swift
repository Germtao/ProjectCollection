//
//  TTPageContentView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/28.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

open class TTPageCollectionViewFlowLayout: UICollectionViewFlowLayout {
    /// 通过设置offset的值来设置显示某一页, 默认第一页
    var offset: CGFloat?
    
    open override func prepare() {
        super.prepare()
        
        guard let offset = offset else { return }
        collectionView?.contentOffset = CGPoint(x: offset, y: 0)
    }
}

open class TTPageContentView: UIView {
    private static let reuseIdentifier = "cellReuseIdentifier"
    
    public weak var delegate: TTPageContentViewDelegate?
    public weak var eventHandleable: TTPageEventHandleable?
    
    public var viewControllers: [UIViewController]
    
    public var style: TTPageStyle
    
    /// 初始化后, 默认显示的页数
    public var currentIndex: Int
    
    // MARK: - 初始化
    public init(frame: CGRect, style: TTPageStyle, viewControllers: [UIViewController], currentIndex: Int) {
        self.viewControllers = viewControllers
        self.style = style
        self.currentIndex = currentIndex
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        viewControllers = [UIViewController]()
        style = TTPageStyle()
        currentIndex = 0
        super.init(coder: aDecoder)
        setupUI()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = bounds
        let layout = collectionView.collectionViewLayout as! TTPageCollectionViewFlowLayout
        layout.itemSize = bounds.size
        layout.offset = CGFloat(currentIndex) * bounds.size.width
    }
    
    // MARK: - 私有
    private lazy var collectionView: UICollectionView = {
        let layout = TTPageCollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.scrollsToTop = false
        view.bounces = false
        view.dataSource = self
        view.delegate = self
        
        if #available(iOS 10.0, *) {
            view.isPrefetchingEnabled = false
        }
        
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: TTPageContentView.reuseIdentifier)
        
        return view
    }()
    
    private var startOffsetX: CGFloat = 0.0
    
    /// 是否禁止代理, 默认false
    private var isForbidDelegate: Bool = false
}

extension TTPageContentView {
    private func setupUI() {
        addSubview(collectionView)
        
        collectionView.backgroundColor = style.contentViewColor
        collectionView.isScrollEnabled = style.isContentViewScrollEnabled
    }
}

extension TTPageContentView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTPageContentView.reuseIdentifier, for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let childVc = viewControllers[indexPath.item]
        
        eventHandleable = childVc as? TTPageEventHandleable
        
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

extension TTPageContentView: UICollectionViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateUI(scrollView)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            collectionViewDidEndScroll(scrollView)
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionViewDidEndScroll(scrollView)
    }
}

extension TTPageContentView {
    private func collectionViewDidEndScroll(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        
        delegate?.pageContentView(self, didEndScrollAt: index)
        
        if index != currentIndex {
            let vc = viewControllers[currentIndex]
            (vc as? TTPageEventHandleable)?.contentViewDidDisappear?()
        }
        
        currentIndex = index
        
        eventHandleable = viewControllers[currentIndex] as? TTPageEventHandleable
        
        eventHandleable?.contentViewDidEndScroll?()
    }
    
    private func updateUI(_ scrollView: UIScrollView) {
        if isForbidDelegate { return }
        
        var progress: CGFloat = 0
        var targetIndex = 0
        var sourceIndex = 0
        
        progress = scrollView.contentOffset.x.truncatingRemainder(dividingBy: scrollView.bounds.width) / scrollView.bounds.width
        if progress == 0 || progress.isNaN { return }
        
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        if collectionView.contentOffset.x > startOffsetX { // 左滑
            sourceIndex = index
            targetIndex = index + 1
            guard targetIndex < viewControllers.count else { return }
        } else { // 右滑
            sourceIndex = index + 1
            targetIndex = index
            progress = 1 - progress
            guard targetIndex >= 0 else { return }
        }
        
        if progress > 0.998 { progress = 1 }
        
        delegate?.pageContentView(self, scrollingWith: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
}
