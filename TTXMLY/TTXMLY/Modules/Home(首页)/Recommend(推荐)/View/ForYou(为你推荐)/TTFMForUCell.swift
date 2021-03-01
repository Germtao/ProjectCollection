//
//  TTFMForUCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/8.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMForUCell: UICollectionViewCell {
    static let reuseIdentifier = "forUcellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var imageView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(17)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(14)
        label.textColor = UIColor.gray
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(14)
        label.textColor = UIColor.gray
        return label
    }()
}

extension TTFMForUCell {
    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(countLabel)
        
        setupUILayout()
    }
    
    private func setupUILayout() {
        imageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.top.equalTo(imageView)
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        countLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(subTitleLabel)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
