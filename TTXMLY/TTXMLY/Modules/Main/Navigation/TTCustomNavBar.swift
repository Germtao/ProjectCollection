//
//  TTCustomNavBar.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/27.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTCustomNavBar: UIView {

    var handleLeftButtonClicked: (() -> Void)?
    var handleRightButtonClicked: (() -> Void)?
    
    var title: String? {
        willSet {
            titleLabel.isHidden = false
            titleLabel.text = newValue
        }
    }
    
    var titleColor: UIColor? {
        willSet {
            titleLabel.textColor = newValue
        }
    }
    
    var titleFont: UIFont? {
        willSet {
            titleLabel.font = newValue
        }
    }
    
    var barBackgroundColor: UIColor? {
        willSet {
            backgroundImageView.isHidden = true
            backgroundView.isHidden = false
            backgroundView.backgroundColor = newValue
        }
    }
    
    var barBackgroundImage: UIImage? {
        willSet {
            backgroundImageView.isHidden = false
            backgroundView.isHidden = true
            backgroundImageView.image = newValue
        }
    }
    
    class func customNavBar() -> TTCustomNavBar {
        let frame = CGRect(x: 0, y: 0, width: Constants.Sizes.screenW, height: Constants.Sizes.navBarH)
        return TTCustomNavBar(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    private func makeUI() {
        addSubview(backgroundView)
        addSubview(backgroundImageView)
        addSubview(leftButton)
        addSubview(titleLabel)
        addSubview(rightButton)
        addSubview(bottomLine)
        
        updateFrame()
        
        backgroundColor = UIColor.clear
        backgroundView.backgroundColor = Constants.Colors.defaultBackground
    }
    
    private func updateFrame() {
        let top = Constants.Sizes.statusBarH
        let buttonHeight: CGFloat = 44
        let buttonWidth: CGFloat = 44
        let titleLabelHeight: CGFloat = 44
        let titleLabelWidth: CGFloat = 180
        
        backgroundView.frame = bounds
        backgroundImageView.frame = bounds
        leftButton.frame = CGRect(x: 0, y: top, width: buttonWidth, height: buttonHeight)
        rightButton.frame = CGRect(x: Constants.Sizes.screenW - buttonWidth, y: top, width: buttonWidth, height: buttonHeight)
        titleLabel.frame = CGRect(x: (Constants.Sizes.screenW - titleLabelWidth) * 0.5, y: top, width: titleLabelWidth, height: titleLabelHeight)
        bottomLine.frame = CGRect(x: 0, y: bounds.height - 0.5, width: Constants.Sizes.screenW, height: 0.5)
    }
    
    // MARK: - UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.defaultTitle
        label.font = Constants.Fonts.defaultFont
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private lazy var leftButton = UIButton.buttonForBarItem(target: self, action: #selector(leftButtonClicked))
    
    private lazy var rightButton = UIButton.buttonForBarItem(target: self, action: #selector(rightButtonClicked))
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.line
        return view
    }()
    
    private lazy var backgroundView = UIView()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        return imageView
    }()
}

extension TTCustomNavBar {
    
    func tt_setBottomLineHidden(_ hidden: Bool) {
        bottomLine.isHidden = hidden
    }
    
    func tt_setBackgroundAlpha(_ alpha: CGFloat) {
        backgroundView.alpha = alpha
        backgroundImageView.alpha = alpha
        bottomLine.alpha = alpha
    }
    
    func tt_setTintColor(_ color: UIColor) {
        leftButton.setTitleColor(color, for: .normal)
        rightButton.setTitleColor(color, for: .normal)
        titleLabel.textColor = color
    }
    
    func tt_setLeftButton(normal normalImage: UIImage, highlighted highlightedImage: UIImage?) {
        if highlightedImage == nil {
            tt_setupButton(leftButton, normal: normalImage, highlighted: normalImage)
        }
        
        if highlightedImage != nil {
            tt_setupButton(leftButton, normal: normalImage, highlighted: highlightedImage)
        }
    }
    
    func tt_setLeftButton(title: String, titleColor: UIColor = Constants.Colors.defaultTitle) {
        tt_setupButton(leftButton, title: title, titleColor: titleColor)
    }
    
    func tt_setRightButton(normal normalImage: UIImage, highlighted highlightedImage: UIImage?) {
        if highlightedImage == nil {
            tt_setupButton(rightButton, normal: normalImage, highlighted: normalImage)
        }
        
        if highlightedImage != nil {
            tt_setupButton(rightButton, normal: normalImage, highlighted: highlightedImage)
        }
    }
    
    func tt_setRightButton(title: String, titleColor: UIColor = Constants.Colors.defaultTitle) {
        tt_setupButton(rightButton, title: title, titleColor: titleColor)
    }
    
    private func tt_setupButton(_ button: UIButton,
                                normal normarlImage: UIImage? = nil,
                                highlighted highlightedImage: UIImage? = nil,
                                title: String? = nil,
                                titleColor: UIColor? = nil) {
        button.isHidden = false
        button.setImage(normarlImage, for: .normal)
        button.setImage(highlightedImage, for: .highlighted)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
    }
}

// MARK: - 左右按钮点击事件
extension TTCustomNavBar {
    @objc private func leftButtonClicked() {
        if let handle = handleLeftButtonClicked {
            handle()
        } else {
            let currentVc = UIViewController.tt_currentViewController()
            currentVc.tt_toLastViewController(true)
        }
    }
    
    @objc private func rightButtonClicked() {
        handleRightButtonClicked?()
    }
}
