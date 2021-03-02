//
//  TTFMHomeBroadcastHeaderView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/15.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMHomeBroadcastHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "homeBroadcastHeaderVeiwID"
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(20)
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("更多 >", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = Constants.Fonts.font(15)
        return button
    }()
}

extension TTFMHomeBroadcastHeaderView {
    private func setupUI() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(moreButton)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(5)
            make.size.equalTo(CGSize(width: 150, height: 30))
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.right.equalTo(15)
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
    }
}
