//
//  TTCarouselViewCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/3.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

open class TTCarouselViewCell: UICollectionViewCell {
    
    /// 返回轮播图cell的text label
    open var textLabel: UILabel? {
        if let _ = _textLabel {
            return _textLabel
        }
        
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let textLabel = UILabel(frame: .zero)
        textLabel.textColor = .white
        textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        contentView.addSubview(view)
        view.addSubview(textLabel)
        
        _textLabel = textLabel
        return textLabel
    }
    
    /// 返回轮播图cell的 image view
    open var imageView: UIImageView? {
        if let _ = _imageView {
            return _imageView
        }
        
        let imageView = UIImageView(frame: .zero)
        contentView.addSubview(imageView)
        _imageView = imageView
        return imageView
    }
    
    open override var isHighlighted: Bool {
        set {
            super.isHighlighted = newValue
            if newValue {
                selectedForegroundView?.layer.backgroundColor = selectionColor.cgColor
            } else if !super.isSelected {
                selectedForegroundView?.layer.backgroundColor = UIColor.clear.cgColor
            }
        }
        get {
            return super.isHighlighted
        }
    }
    
    open override var isSelected: Bool {
        set {
            super.isSelected = newValue
            selectedBackgroundView?.layer.backgroundColor = newValue ? selectionColor.cgColor : UIColor.clear.cgColor
        }
        get {
            return super.isSelected
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    deinit {
        if let textLabel = _textLabel {
            textLabel.removeObserver(self, forKeyPath: "font", context: kvoContext)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if let imageView = _imageView {
            imageView.frame = contentView.bounds
        }
        
        if let textLabel = _textLabel {
            textLabel.superview!.frame = {
                var rect = contentView.bounds
                let height = textLabel.font.pointSize * 1.5
                rect.size.height = height
                rect.origin.y = contentView.frame.height - height
                return rect
            }()
            textLabel.frame = {
                var rect = textLabel.superview!.bounds
                rect = rect.insetBy(dx: 8, dy: 0)
                rect.size.height -= 1
                rect.origin.y += 1
                return rect
            }()
        }
        
        if let selectedForegroundView = _selectedForegroundView {
            selectedForegroundView.frame = contentView.bounds
        }
    }
    
    // MARK: - KVO
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == kvoContext {
            if keyPath == "font" {
                setNeedsLayout()
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    // MARK: - 私有属性
    private weak var _textLabel: UILabel?
    private weak var _imageView: UIImageView?
    
    private let kvoContext = UnsafeMutableRawPointer(bitPattern: 0)
    private let selectionColor = UIColor(white: 0.2, alpha: 0.2)
    
    private weak var _selectedForegroundView: UIView?
    private var selectedForegroundView: UIView? {
        guard _selectedForegroundView == nil else {
            return _selectedForegroundView
        }
        
        guard let imageView = _imageView else { return nil }
        
        let view = UIView(frame: imageView.bounds)
        imageView.addSubview(view)
        _selectedForegroundView = view
        return view
    }
}

extension TTCarouselViewCell {
    private func commonInit() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 5.0
        contentView.layer.shadowOpacity = 0.75
        contentView.layer.shadowOffset = .zero
    }
}
