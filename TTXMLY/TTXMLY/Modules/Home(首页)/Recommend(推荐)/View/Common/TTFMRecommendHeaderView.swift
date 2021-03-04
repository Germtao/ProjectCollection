//
//  TTFMRecommendHeaderView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/5.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

typealias TTFMRecommendHeaderViewHandler = () -> Void

class TTFMRecommendHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "recommendHeaderViewID"
    
    /// 点击更多回调
    var tapMoreHandler: TTFMRecommendHeaderViewHandler?
    
    func configure(with model: TTFMRecommendModel?) {
        titleLabel.text = model?.title != nil ? model?.title : "猜你喜欢"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    // MARK: - 懒加载
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(20)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(15)
        label.textColor = UIColor.lightGray
        label.textAlignment = .right
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("更多 >", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = Constants.Fonts.font(15)
        button.addTarget(self, action: #selector(moreButtonClicked), for: .touchUpInside)
        return button
    }()
}

extension TTFMRecommendHeaderView {
    
    private func makeUI() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(moreButton)
        
        setupUILayout()
    }
    
    private func setupUILayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right)
            make.height.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-100)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-8)
            make.width.equalTo(100)
        }
    }
    
    @objc private func moreButtonClicked() {
        tapMoreHandler?()
    }
}
