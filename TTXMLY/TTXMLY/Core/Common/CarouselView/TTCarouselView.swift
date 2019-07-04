//
//  TTCarouselView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/3.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

open class TTCarouselView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    /// 数据源
    open weak var dataSource: TTCarouselViewDataSource?
    
    /// 代理
    open weak var delegate: TTCarouselViewDelegate?
    
    /// 滚动方向, 默认 .horizontal
    open var scrollDirection: TTCarouselView.ScrollDirection = .horizontal {
        didSet {
            collectionViewLayout.forceInvalidate()
        }
    }
    
    /// 自动滑动的时间间隔, 0 - 表示禁用自动滑动, 默认 0
    open var automaticSlidingInterval: CGFloat = 0.0 {
        didSet {
            cancelTimer()
            if self.automaticSlidingInterval > 0 {
                startTimer()
            }
        }
    }
    
    /// items之间的间隙, 默认 0
    open var interitemSpacing: CGFloat = 0.0 {
        didSet {
            collectionViewLayout.forceInvalidate()
        }
    }
    
    /// item尺寸, automaticSize表示填充整个carouselView可见区域, 默认 automaticSize
    open var itemSize: CGSize = automaticSize {
        didSet {
            collectionViewLayout.forceInvalidate()
        }
    }
    
    /// 是否无限循环, 默认 false
    open var isInfinite: Bool = false {
        didSet {
            reloadData()
        }
    }
    
    /// carouselView减速滚动时, 滚动的距离, 默认 1
    open var decelerationDistance: UInt = 1
    
    /// 是否能滚动
    open var isScrollEnable: Bool {
        set { collectionView.isScrollEnabled = newValue }
        get { return collectionView.isScrollEnabled }
    }
    
    /// 是否有弹簧效果
    open var bounces: Bool {
        set { collectionView.bounces = newValue }
        get { return collectionView.bounces }
    }
    
    /// 总是水平方向弹簧效果
    open var alwaysBounceHorizontal: Bool {
        set { collectionView.alwaysBounceHorizontal = newValue }
        get { return collectionView.alwaysBounceHorizontal }
    }
    
    /// 总是垂直方向弹簧效果
    open var alwaysBounceVertical: Bool {
        set { collectionView.alwaysBounceVertical = newValue }
        get { return collectionView.alwaysBounceVertical }
    }
    
    /// 一个item时, 是否移除无限循环, 默认 false
    open var removesInfiniteLoopForSingleItem: Bool = false {
        didSet {
            reloadData()
        }
    }
    
    /// 背景视图
    open var backgroundView: UIView? {
        didSet {
            if let backgroundView = self.backgroundView {
                if backgroundView.superview != nil {
                    backgroundView.removeFromSuperview()
                }
                insertSubview(backgroundView, at: 0)
                setNeedsLayout()
            }
        }
    }
    
    /// 转场属性
    open var transformer: TTCarouselViewTransformer? {
        didSet {
            self.transformer?.carouselView = self
            collectionViewLayout.forceInvalidate()
        }
    }
    
    // MARK: - read-only properties
    
    /// 用户是否触摸了内容, 以启动滚动
    open var isTracking: Bool {
        return collectionView.isTracking
    }
    
    /// 内容视图origin偏离carouselView视图origin的x位置百分比。
    open var scrollOffset: CGFloat {
        let contentOffset = max(collectionView.contentOffset.x, collectionView.contentOffset.y)
        let scrollOffset = contentOffset / collectionViewLayout.itemSpacing
        return scrollOffset
    }
    
    open private(set) var currentIndex: Int = 0
    
    // MARK: - 私有属性
    weak var collectionViewLayout: TTCarouselViewLayout!
    weak var collectionView: TTCarouselCollectionView!
    weak var contentView: UIView!
    var timer: Timer?
    private var numberOfItems: Int = 0
    private var numberOfSections: Int = 0
    
    private var dequeingSection = 0
    private var centermostIndexPath: IndexPath {
        guard numberOfItems > 0, collectionView.contentSize != .zero else {
            return IndexPath(item: 0, section: 0)
        }
        let sortedIndexPaths = collectionView.indexPathsForVisibleItems.sorted { (l, r) -> Bool in
            let leftFrame = collectionViewLayout.frame(for: l)
            let rightFrame = collectionViewLayout.frame(for: r)
            var leftCenter: CGFloat, rightCenter: CGFloat, ruler: CGFloat
            switch scrollDirection {
            case .horizontal:
                leftCenter = leftFrame.midX
                rightCenter = rightFrame.midX
                ruler = collectionView.bounds.midX
            case .vertical:
                leftCenter = leftFrame.midY
                rightCenter = rightFrame.midY
                ruler = collectionView.bounds.midY
            }
            return abs(ruler - leftCenter) < abs(ruler - rightCenter)
        }
        guard let indexPath = sortedIndexPaths.first else {
            return IndexPath(item: 0, section: 0)
        }
        return indexPath
    }
    
    private var possibleTargetingIndexPath: IndexPath?
    
    private var isPossiblyRotating: Bool {
        guard let animationKeys = contentView.layer.animationKeys() else { return false }
        let rotationAnimationKeys = ["position", "bounds.origin", "bounds.size"]
        return animationKeys.contains(where: { rotationAnimationKeys.contains($0) })
    }
    
    // MARK: - override functions
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView?.frame = bounds
        contentView.frame = bounds
        collectionView.frame = contentView.bounds
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow != nil {
            startTimer()
        } else {
            cancelTimer()
        }
    }
    
    deinit {
        collectionView.dataSource = nil
        collectionView.delegate = nil
    }
}

// MARK: - Public Functions
extension TTCarouselView {
    /// 刷新数据
    public func reloadData() {
        collectionViewLayout.needsReprepare = true
        collectionView.reloadData()
    }
    
    /// 注册cell
    open func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    /// 注册 nib cell
    open func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    /// cell reusable
    open func dequeueReusableCell(withReuseIdentifier identifier: String, for index: Int) -> TTCarouselViewCell {
        let indexPath = IndexPath(item: index, section: dequeingSection)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard cell.isKind(of: TTCarouselViewCell.self) else {
            fatalError("Cell class must be subclass of TTCarouselViewCell")
        }
        return cell as! TTCarouselViewCell
    }
    
    /// cell select
    open func selectItem(at index: Int, animated: Bool) {
        let indexPath = nearByIndexPath(for: index)
        let scrollPosition: UICollectionView.ScrollPosition = scrollDirection == .horizontal ? .centeredHorizontally : .centeredVertically
        collectionView.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }
    
    /// cell deselect
    open func deselectItem(at index: Int, animated: Bool) {
        let indexPath = nearByIndexPath(for: index)
        collectionView.deselectItem(at: indexPath, animated: animated)
    }
    
    /// scroll to specified item is visible
    open func scrollToItem(at index: Int, animated: Bool) {
        guard index < numberOfItems else {
            fatalError("index \(index) is out of range [0...\(numberOfItems-1)]")
        }
        let indexPath = { () -> IndexPath in
            if let indexPath = possibleTargetingIndexPath, indexPath.item == index {
                defer {
                    possibleTargetingIndexPath = nil
                }
                return indexPath
            }
            return numberOfSections > 1 ? nearByIndexPath(for: index) : IndexPath(item: index, section: 0)
        }()
        let contentOffset = collectionViewLayout.contentOffset(for: indexPath)
        collectionView.setContentOffset(contentOffset, animated: animated)
    }
    
    /// return index of specified item
    open func index(for cell: TTCarouselViewCell) -> Int {
        guard let indexPath = collectionView.indexPath(for: cell) else { return NSNotFound }
        return indexPath.item
    }
    
    /// return the visible cell at the specified index
    open func cellForItem(at index: Int) -> TTCarouselViewCell? {
        let indexPath = nearByIndexPath(for: index)
        return collectionView.cellForItem(at: indexPath) as? TTCarouselViewCell
    }
}

// MARK: - UICollectionViewDataSource
extension TTCarouselView {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let dataSource = dataSource else { return 1 }
        numberOfItems = dataSource.numberOfItems(in: self)
        guard numberOfItems > 0 else { return 0 }
        numberOfSections = isInfinite && (numberOfItems > 1 || !removesInfiniteLoopForSingleItem) ? Int(Int16.max) / numberOfItems : 1
        return numberOfSections
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        dequeingSection = indexPath.section
        let cell = dataSource!.carouselView(self, cellForItemAt: indexPath.item)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension TTCarouselView {
    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        guard let function = delegate?.carouselView(_:shouleHighlightItemAt:) else { return true }
        return function(self, indexPath.item % numberOfItems)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let function = delegate?.carouselView(_:didHighlightItemAt:) else { return }
        function(self, indexPath.item % numberOfItems)
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let function = delegate?.carouselView(_:shouldSelectItemAt:) else { return true }
        return function(self, indexPath.item % numberOfItems)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let function = delegate?.carouselView(_:didSelectItemAt:) else { return }
        self.possibleTargetingIndexPath = indexPath
        defer {
            self.possibleTargetingIndexPath = nil
        }
        function(self, indexPath.item % numberOfItems)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let function = delegate?.carouselView(_:willDisplay:forItemAt:) else { return }
        function(self, cell as! TTCarouselViewCell, indexPath.item % numberOfItems)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let function = delegate?.carouselView(_:didEndDisplaying:forItemAt:) else { return }
        function(self, cell as! TTCarouselViewCell, indexPath.item % numberOfItems)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isPossiblyRotating && numberOfItems > 0 {
            // In case someone is using KVO
            let currentIndex = lround(Double(scrollOffset)) % numberOfItems
            if currentIndex != self.currentIndex {
                self.currentIndex = currentIndex
            }
        }
        
        guard let function = delegate?.carouselViewDidScroll else { return }
        function(self)
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let function = delegate?.carouselViewWillBeginDragging(_:) {
            function(self)
        }
        
        if automaticSlidingInterval > 0 {
            cancelTimer()
        }
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let function = delegate?.carouselViewWillEndDragging(_:targetIndex:) {
            let contentOffset = scrollDirection == .horizontal ? targetContentOffset.pointee.x : targetContentOffset.pointee.y
            let targetItem = lround(Double(contentOffset / collectionViewLayout.itemSpacing))
            function(self, targetItem % numberOfItems)
        }
        
        if automaticSlidingInterval > 0 {
            startTimer()
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let function = delegate?.carouselViewDidEndDecelerating {
            function(self)
        }
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if let function = delegate?.carouselViewDidEndScrollAnmiation {
            function(self)
        }
    }
}

// MARK: - private functions
extension TTCarouselView {
    /// 初始化
    private func commonInit() {
        let contentView = UIView(frame: .zero)
        contentView.backgroundColor = .clear
        addSubview(contentView)
        self.contentView = contentView
        
        let layout = TTCarouselViewLayout()
        let collectionView = TTCarouselCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        contentView.addSubview(collectionView)
        self.collectionView = collectionView
        self.collectionViewLayout = layout
    }
    
    /// 开启定时器
    private func startTimer() {
        guard automaticSlidingInterval > 0 && timer == nil else { return }
        timer = Timer(timeInterval: TimeInterval(automaticSlidingInterval),
                      target: self,
                      selector: #selector(flipNext(_:)),
                      userInfo: nil,
                      repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    /// 自动下一页
    @objc private func flipNext(_ timer: Timer) {
        guard let _ = superview, let _ = window, numberOfItems > 0, !isTracking else { return }
        let contentOffset: CGPoint = {
            let section = numberOfSections > 1 ? (centermostIndexPath.section + (centermostIndexPath.item + 1) / numberOfItems) : 0
            let item = (centermostIndexPath.item + 1) % numberOfItems
            return collectionViewLayout.contentOffset(for: IndexPath(item: item, section: section))
        }()
        collectionView.setContentOffset(contentOffset, animated: true)
    }
    
    /// 取消定时器
    private func cancelTimer() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
    }
    
    /// 计算显示的 indexPath
    private func nearByIndexPath(for index: Int) -> IndexPath {
        // TODO: 还可以优化算法
        let currentIndex = self.currentIndex
        let currentSection = centermostIndexPath.section
        if abs(currentIndex - index) <= numberOfItems / 2 {
            return IndexPath(item: index, section: currentSection)
        } else if index - currentIndex >= 0 {
            return IndexPath(item: index, section: currentSection - 1)
        } else {
            return IndexPath(item: index, section: currentSection + 1)
        }
    }
}

extension TTCarouselView {
    /// 滚动方向
    public enum ScrollDirection: Int {
        /// 水平滚动
        case horizontal
        /// 垂直滚动
        case vertical
    }
    
    /// 请求 carouselView 使用给定距离, 默认 0
    public static let automaticDistance: UInt = 0
    
    /// 请求 carouselView 使用给定尺寸, 默认 zero
    public static let automaticSize: CGSize = .zero
}
