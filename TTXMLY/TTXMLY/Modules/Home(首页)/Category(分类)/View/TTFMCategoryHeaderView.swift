//
//  TTFMCategoryHeaderView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/9.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMCategoryHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "categoryHeaderViewID"
    
    func configure(with text: String?) {
        titleLabel.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.button
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
}

extension TTFMCategoryHeaderView {
    private func setupUI() {
        backgroundColor = Constants.Colors.sectionFooter
        addSubview(view)
        addSubview(titleLabel)
        
        view.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
            make.width.equalTo(4)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.right).offset(10)
            make.right.equalTo(-10)
            make.top.bottom.equalToSuperview()
        }
    }
}
