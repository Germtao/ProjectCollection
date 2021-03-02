//
//  TTFMVipHeaderView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/9.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMVipHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "vipHeaderViewID"
    
    func configure(with title: String?) {
        titleLabel.text = title
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        tintColor = .red
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lazy load
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

extension TTFMVipHeaderView {
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(moreButton)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.size.equalTo(CGSize(width: 150, height: 30))
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.right.equalTo(15)
            make.top.equalTo(10)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
    }
}
