//
//  TTFMLiveCategoryCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/11.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMLiveCategoryCell: UICollectionViewCell {
    static let reuseIdentifier = "liveCategoryCellID"
    
    func configure(imageName: String, title: String) {
        imageView.kf.setImage(with: URL(string: imageName))
        titleLabel.text = title
    }
    
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
        label.font = Constants.Fonts.font(13)
        label.textAlignment = .center
        return label
    }()
}

extension TTFMLiveCategoryCell {
    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 45, height: 45))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
    }
}
