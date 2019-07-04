//
//  TTCarouselCollectionView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/3.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTCarouselCollectionView: UICollectionView {

    override var contentInset: UIEdgeInsets {
        set {
            super.contentInset = .zero
            if newValue.top > 0 {
                let newContentOffset = CGPoint(x: contentOffset.x, y: contentOffset.y + newValue.top)
                contentOffset = newContentOffset
            }
        }
        get {
            return super.contentInset
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

extension TTCarouselCollectionView {
    private func commonInit() {
        contentInset = .zero
        decelerationRate = .fast
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        if #available(iOS 10.0, *) {
            isPrefetchingEnabled = false
        }
        
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
    }
}
