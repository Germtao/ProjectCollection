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
    var handler: TTFMRecommendHeaderViewHandler?
    
    func configure(with model: TTFMRecommendModel?) {
        guard let model = model else { return }
        titleLabel.text = model.title != nil ? model.title : "猜你喜欢"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(20)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(15)
        label.textColor = UIColor.lightGray
        label.textAlignment = .right
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("更多 >", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = TTFont.font(15)
        button.addTarget(self, action: #selector(moreButtonClicked), for: .touchUpInside)
        return button
    }()
}

extension TTFMRecommendHeaderView {
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(moreButton)
        
        setupUILayout()
    }
    
    private func setupUILayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.size.equalTo(CGSize(width: 150, height: 30))
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right)
            make.height.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-100)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.right.top.equalTo(15)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
    }
    
    @objc private func moreButtonClicked() {
        guard let handler = handler else { return }
        handler()
    }
}
