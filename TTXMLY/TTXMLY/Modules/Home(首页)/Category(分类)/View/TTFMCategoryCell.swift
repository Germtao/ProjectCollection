//
//  TTFMCategoryCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/9.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMCategoryCell: UICollectionViewCell {
    static let reuseIdentifier = "categoryCellID"
    
    func configure(with model: TTFMCategoryItemList?) {
        guard let model = model else { return }
        if model.itemType == 1 { // 如果是第一个item, 有图片显示且字体较小
            titleLabel.text = model.itemDetail?.keywordName
        } else {
            titleLabel.text = model.itemDetail?.title
            if model.coverPath != nil {
                imageView.kf.setImage(with: URL(string: model.coverPath!))
            }
        }
    }
    
    /// 前三个分区第一个item的字体较小
    var indexPath: IndexPath? {
        didSet {
            guard let indexPath = indexPath else { return }
            switch indexPath.section {
            case 0, 1, 2:
                if indexPath.item == 0 {
                    titleLabel.font = Constants.Fonts.font(13)
                } else {
                    imageView.snp.updateConstraints { (make) in
                        make.left.equalToSuperview()
                        make.width.equalTo(0)
                    }
                    titleLabel.textAlignment = .center
                    titleLabel.snp.updateConstraints { (make) in
                        make.left.equalTo(imageView.snp.right)
                        make.width.equalToSuperview()
                    }
                }
            default: break
            }
        }
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
        label.font = Constants.Fonts.font(15)
        return label
    }()
}

extension TTFMCategoryCell {
    private func setupUI() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
        contentView.layer.borderColor = Constants.Colors.categoryCell.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(5)
            make.top.bottom.equalTo(imageView)
            make.width.equalToSuperview().offset(-imageView.frame.width)
        }
    }
}
