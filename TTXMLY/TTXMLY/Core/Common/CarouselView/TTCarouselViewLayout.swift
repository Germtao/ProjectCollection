//
//  TTCarouselViewLayout.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/3.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTCarouselViewLayout: UICollectionViewLayout {
    
    var contentSize: CGSize = .zero
    /// 左边间距
    var leadingSpacing: CGFloat = 0.0
    var itemSpacing: CGFloat = 0.0
    var needsReprepare = true
    /// 滚动方向, 默认 .horizontal
    var scrollDirection: TTCarouselView.ScrollDirection = .horizontal
    
    open override class var layoutAttributesClass: AnyClass {
        return TTCarouselViewLayoutAttributes.self
    }
    
    private var carouselView: TTCarouselView? {
        return collectionView?.superview?.superview as? TTCarouselView
    }
    
    private var collectionViewSize: CGSize = .zero
    private var numberOfSections: Int = 1
    private var numberOfItems: Int = 0
    /// item实际间距
    private var actualInteritemSpacing: CGFloat = 0.0
    /// item 实际尺寸
    private var actualItemSize: CGSize = .zero
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        
    }
    
    override func prepare() {
        guard let collectionView = collectionView, let carouselView = carouselView else { return }
        guard needsReprepare || collectionViewSize != collectionView.frame.size else { return }
        
        needsReprepare = false
        collectionViewSize = collectionView.frame.size
        
        // Calculate basic parameters/variables
        numberOfSections = carouselView.numberOfSections(in: collectionView)
        numberOfItems = carouselView.collectionView(collectionView, numberOfItemsInSection: 0)
        actualItemSize = {
            var size = carouselView.itemSize
            if size == .zero {
                size = collectionView.frame.size
            }
            return size
        }()
        
        actualInteritemSpacing = {
            if let transformer = carouselView.transformer {
                return transformer.proposedInteritemSpacing()
            }
            return carouselView.interitemSpacing
        }()
        
        scrollDirection = carouselView.scrollDirection
        leadingSpacing = scrollDirection == .horizontal ? (collectionView.frame.width - actualItemSize.width) * 0.5 : ( collectionView.frame.height - actualItemSize.height) * 0.5
        itemSpacing = (scrollDirection == .horizontal ? actualItemSize.width : actualItemSize.height) + actualInteritemSpacing
        
        // Calculate and cache contentSize, rather than calculating each time
        contentSize = {
            let numberOfItems = self.numberOfItems * numberOfSections
            switch scrollDirection {
            case .horizontal:
                var contentSizeWidth = leadingSpacing * 2 // Leading & trailing spacing
                contentSizeWidth += CGFloat(numberOfItems - 1) * actualInteritemSpacing // Interitem spacing
                contentSizeWidth += CGFloat(numberOfItems) * actualItemSize.width // Item sizes
                let contentSize = CGSize(width: contentSizeWidth, height: collectionView.frame.height)
                return contentSize
            case .vertical:
                var contentSizeHeight = leadingSpacing * 2 // Leading & trailing spacing
                contentSizeHeight += CGFloat(numberOfItems - 1) * actualInteritemSpacing // Interitem spacing
                contentSizeHeight += CGFloat(numberOfItems) * actualItemSize.height // Item sizes
                let contentSize = CGSize(width: collectionView.frame.width, height: contentSizeHeight)
                return contentSize
            }
        }()
        adjustCollectionViewBounds()
    }
}

extension TTCarouselViewLayout {
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        guard itemSpacing > 0, !rect.isEmpty else { return layoutAttributes }
        let rect = rect.intersection(CGRect(origin: .zero, size: contentSize))
        guard !rect.isEmpty else { return layoutAttributes }
        // Calculate start position and index of certain rects
        let numberOfItemBefore = scrollDirection == .horizontal ? max(Int((rect.minX - leadingSpacing) / itemSpacing), 0) : max(Int((rect.minY - leadingSpacing) / itemSpacing), 0)
        let startPosition = leadingSpacing + CGFloat(numberOfItemBefore) * itemSpacing
        let startIndex = numberOfItemBefore
        // create layout attributes
        var itemIndex = startIndex
        
        var origin = startPosition
        let maxPosition = scrollDirection == .horizontal ? min(rect.maxX, contentSize.width - actualItemSize.width - leadingSpacing) : min(rect.maxY, contentSize.height - actualItemSize.height - leadingSpacing)
        // https://stackoverflow.com/a/10335601/2398107
        while origin - maxPosition <= max(CGFloat(100.0) * .ulpOfOne * abs(origin + maxPosition), .leastNonzeroMagnitude) {
            let indexPath = IndexPath(item: itemIndex % numberOfItems, section: itemIndex / numberOfItems)
            let attributes = layoutAttributesForItem(at: indexPath) as! TTCarouselViewLayoutAttributes
            applyTransform(to: attributes, with: carouselView?.transformer)
            layoutAttributes.append(attributes)
            itemIndex += 1
            origin += itemSpacing
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = TTCarouselViewLayoutAttributes(forCellWith: indexPath)
        attributes.indexPath = indexPath
        let frame = self.frame(for: indexPath)
        let center = CGPoint(x: frame.midX, y: frame.midY)
        attributes.center = center
        attributes.size = actualItemSize
        return attributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView,
            let carouselView = carouselView else { return proposedContentOffset }
        var proposedContentOffset = proposedContentOffset
        
        func calculateTargetOffset(by proposedOffset: CGFloat, boundedOffset: CGFloat) -> CGFloat {
            var targetOffset: CGFloat
            if carouselView.decelerationDistance == TTCarouselView.automaticDistance {
                if abs(velocity.x) >= 0.3 {
                    let vector: CGFloat = velocity.x >= 0 ? 1.0 : -1.0
                    // Ceil by 0.15, rather than 0.5
                    targetOffset = round(proposedOffset / itemSpacing + 0.35 * vector) * itemSpacing
                } else {
                    targetOffset = round(proposedOffset / itemSpacing) * itemSpacing
                }
            } else {
                let extraDistance = max(carouselView.decelerationDistance - 1, 0)
                switch velocity.x {
                case 0.3 ... CGFloat.greatestFiniteMagnitude:
                    targetOffset = ceil(collectionView.contentOffset.x / itemSpacing + CGFloat(extraDistance)) * itemSpacing
                case -CGFloat.greatestFiniteMagnitude ... -0.3:
                    targetOffset = floor(collectionView.contentOffset.x / itemSpacing - CGFloat(extraDistance)) * itemSpacing
                default:
                    targetOffset = round(proposedOffset / itemSpacing) * itemSpacing
                }
            }
            targetOffset = max(0, targetOffset)
            targetOffset = min(boundedOffset, targetOffset)
            return targetOffset
        }
        
        let proposedContentOffsetX: CGFloat = {
            if scrollDirection == .vertical {
                return proposedContentOffset.x
            }
            let boundedOffset = collectionView.contentSize.width - itemSpacing
            return calculateTargetOffset(by: proposedContentOffset.x, boundedOffset: boundedOffset)
        }()
        
        let proposedContentOffsetY: CGFloat = {
            if scrollDirection == .horizontal {
                return proposedContentOffset.y
            }
            let boundedOffset = collectionView.contentSize.height - itemSpacing
            return calculateTargetOffset(by: proposedContentOffset.y, boundedOffset: boundedOffset)
        }()
        
        proposedContentOffset = CGPoint(x: proposedContentOffsetX, y: proposedContentOffsetY)
        return proposedContentOffset
    }
}

// MARK: - Internal Functions
extension TTCarouselViewLayout {
    /// indexPath frame
    func frame(for indexPath: IndexPath) -> CGRect {
        let numberOfItems = self.numberOfItems * indexPath.section + indexPath.item
        let originX: CGFloat = {
            if scrollDirection == .vertical {
                return (collectionView!.frame.width - actualItemSize.width) * 0.5
            }
            return leadingSpacing + CGFloat(numberOfItems) * itemSpacing
        }()
        let originY: CGFloat = {
            if scrollDirection == .horizontal {
                return (collectionView!.frame.height - actualItemSize.height) * 0.5
            }
            return leadingSpacing + CGFloat(numberOfItems) * itemSpacing
        }()
        let origin = CGPoint(x: originX, y: originY)
        let frame = CGRect(origin: origin, size: actualItemSize)
        return frame
    }
    
    /// conetent offset
    func contentOffset(for indexPath: IndexPath) -> CGPoint {
        let origin = frame(for: indexPath).origin
        guard let collectionView = collectionView else { return origin }
        let contentOffsetX: CGFloat = {
            if scrollDirection == .vertical {
                return 0.0
            }
            let offsetX = origin.x - (collectionView.frame.width - actualItemSize.width) * 0.5
            return offsetX
        }()
        let contentOffsetY: CGFloat = {
            if scrollDirection == .horizontal {
                return 0.0
            }
            let offsetY = origin.y - (collectionView.frame.height - actualItemSize.height) * 0.5
            return offsetY
        }()
        return CGPoint(x: contentOffsetX, y: contentOffsetY)
    }
    
    /// 强制无效
    func forceInvalidate() {
        needsReprepare = true
        invalidateLayout()
    }
}

// MARK: - Private Functions
extension TTCarouselViewLayout {
    /// 适应collectionview bounds
    private func adjustCollectionViewBounds() {
        guard let collectionView = collectionView, let carouselView = carouselView else { return }
        let currentIndex = carouselView.currentIndex
        let newIndexPath = IndexPath(item: currentIndex, section: carouselView.isInfinite ? numberOfSections / 2 : 0)
        let contentOffset = self.contentOffset(for: newIndexPath)
        let newBounds = CGRect(origin: contentOffset, size: collectionView.frame.size)
        collectionView.bounds = newBounds
    }
    
    private func applyTransform(to attributes: TTCarouselViewLayoutAttributes, with transformer: TTCarouselViewTransformer?) {
        guard let collectionView = collectionView else { return }
        guard let transformer = transformer else { return }
        switch scrollDirection {
        case .horizontal:
            let ruler = collectionView.bounds.midX
            attributes.position = (attributes.center.x - ruler) / itemSpacing
        case .vertical:
            let ruler = collectionView.bounds.midY
            attributes.position = (attributes.center.y - ruler) / itemSpacing
        }
        attributes.zIndex = Int(numberOfItems) - Int(attributes.position)
        transformer.applyTransform(to: attributes)
    }
}
