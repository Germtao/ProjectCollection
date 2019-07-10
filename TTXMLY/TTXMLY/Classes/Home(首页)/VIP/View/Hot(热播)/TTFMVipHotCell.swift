//
//  TTFMVipHotCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMVipHotCell: UICollectionViewCell {
    static let reuseIdentifier = "vipHotCellID"
    
    func configure(with model: TTFMCategoryContents?) {
        guard let model = model else { return }
        if model.coverLarge != nil {
            imageView.kf.setImage(with: URL(string: model.coverLarge!))
        }
        titleLabel.text = model.title
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
        label.font = TTFont.font(16)
        label.numberOfLines = 0
        return label
    }()
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
    }
}
