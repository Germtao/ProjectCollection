//
//  StarRatingView.swift
//  iOSCollection
//
//  Created by TT on 2020/3/22.
//  Copyright © 2020 tao Tao. All rights reserved.
//

import UIKit

private let maxStarsCount: Int = 5
private let minStarsCount: Float = 0

@objc protocol StarRatingViewDelegate {
    // 返回星星评分的分值
    @objc optional func starRatingView(_ starRatingView:StarRatingView, count: Float)
}

class StarRatingView: UIView {
    
    weak var delegate: StarRatingViewDelegate?

    /// 是否整星, 默认 false
    var wholeStar: Bool = false {
        didSet {
            showStarRating()
        }
    }
    
    /// 是否可以滑动, 默认 false
    var slideEnable: Bool = false {
        didSet {
            if slideEnable {
                let pan = UIPanGestureRecognizer(target: self, action: #selector(slideStar(_:)))
                addGestureRecognizer(pan)
            }
        }
    }
    
    /// 是否可以点击, 默认 false
    var clickEnable: Bool = false {
        didSet {
            if clickEnable {
                let tap = UITapGestureRecognizer(target: self,action: #selector(clickStar(_:)))
                addGestureRecognizer(tap)
            }
        }
    }
    
    private var _starDuration: TimeInterval = 0.1
    /// 滑动动画时长, 默认 0.1
    var starDuration: TimeInterval {
        set {
            _starDuration = newValue
        }
        get {
            return _starDuration
        }
    }
    
    private var starForegroundView: UIView?
    private var starBackgroundView: UIView?
    
    private var _currentStarCount: Float = 0
    /// 当前的星星数量
    var currentStarCount: Float {
        set {
            _currentStarCount = newValue
            showStarRating()
        }
        get {
            return _currentStarCount
        }
    }
    
    private var _numberOfStars: Int = 5
    /// 星星总数量
    var numberOfStars: Int {
        set {
            _numberOfStars = newValue
        }
        get {
            return _numberOfStars
        }
    }
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Setting
extension StarRatingView {
    private func setupUI() {
        clipsToBounds = true
        numberOfStars = maxStarsCount
        currentStarCount = minStarsCount
        
        starBackgroundView = initStarView(with: "backgroundStar")
        addSubview(starBackgroundView!)
        
        starForegroundView = initStarView(with: "foregroundStar")
        addSubview(starForegroundView!)
        
        showStarRating()
    }
}

// MARK: - Action Event
extension StarRatingView {
    @objc private func slideStar(_ pan: UIPanGestureRecognizer) {
        var offsetX: CGFloat = 0
        switch pan.state {
        case .began:
            offsetX = pan.location(in: self).x
        case .changed:
            offsetX += pan.location(in: self).x
        case .ended:
            offsetX = pan.location(in: self).x
        default:
            break
        }
        currentStarCount = Float((offsetX / bounds.width) * CGFloat(numberOfStars))
        showStarRating()
        protocolHandler()
    }
    
    @objc private func clickStar(_ tap: UITapGestureRecognizer) {
        let offsetX = tap.location(in: self).x
        currentStarCount = Float((offsetX / bounds.width) * CGFloat(numberOfStars))
        showStarRating()
        protocolHandler()
    }
}

// MARK: - Helpers
extension StarRatingView {
    private func initStarView(with imageName: String) -> UIView {
        let starView = UIView(frame: bounds)
        starView.clipsToBounds = true
        
        // 添加星星
        let width = (frame.width - 40) / CGFloat(numberOfStars)
        for i in 0..<numberOfStars {
            let starFrame = CGRect(x: CGFloat(i) * (width + 10), y: 0, width: width, height: bounds.height)
            let imageView = UIImageView(frame: starFrame)
            imageView.image = UIImage(named: imageName)
            starView.addSubview(imageView)
        }
        return starView
    }
    
    // 显示评分
    private func showStarRating() {
        UIView.animate(withDuration: starDuration, animations: {
            if !self.wholeStar {
                let starFrame = CGRect(x: 0,
                                       y: 0,
                                       width: (self.bounds.width - 40) / CGFloat(self.numberOfStars) * CGFloat(self.currentStarCount) + CGFloat(ceil(self.currentStarCount) - 1) * 10,
                                       height: self.bounds.height)
                self.starForegroundView?.frame = starFrame
            } else { // 只支持整星评分
                let starFrame = CGRect(x: 0,
                                       y: 0,
                                       width: (self.bounds.width - 40) / CGFloat(self.numberOfStars) * CGFloat(ceil(self.currentStarCount)) + CGFloat(ceil(self.currentStarCount) - 1) * 10,
                                       height: self.bounds.height)
                self.starForegroundView?.frame = starFrame
            }
        })
    }
    
    /// 协议回调
    private func protocolHandler() {
        if let delegate = delegate {
            var newStar: Float = wholeStar ? Float(ceil(currentStarCount)) : currentStarCount
            if newStar > Float(numberOfStars) {
                newStar = Float(numberOfStars)
            } else if newStar < 0 {
                newStar = 0
            }
            
            delegate.starRatingView?(self, count: newStar)
        }
    }
}
