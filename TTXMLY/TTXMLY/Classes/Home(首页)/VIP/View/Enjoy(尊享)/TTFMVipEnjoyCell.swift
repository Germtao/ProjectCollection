//
//  TTFMVipEnjoyCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMVipEnjoyCell: UICollectionViewCell {
    static let reuseIdentifier = "vipEnjoyCellID"
    
    func configure(with model: TTFMCategoryContents?) {
        guard let model = model else { return }
        if model.coverLarge != nil {
            imageView.kf.setImage(with: URL(string: model.coverLarge!))
        }
        titleLabel.text = model.title
        
        let text = NSMutableAttributedString(string: "")
        text.append(NSAttributedString(string: " \(model.displayDiscountedPrice ?? "0") ",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red,
                         NSAttributedString.Key.font: TTFont.font(13)]))
        happinessLabel.attributedText = text
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
    
    /// 喜点label
    private lazy var happinessLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(13)
        return label
    }()
    
    /// 会员免费
    private lazy var freeLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(12)
        label.text = "会员免费"
        label.backgroundColor = Color.vipFreeBg
        label.textColor = .white
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true
        return label
    }()
    
    
}

extension TTFMVipEnjoyCell {
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(happinessLabel)
        contentView.addSubview(freeLabel)
        
        setupUILayout()
    }
    
    private func setupUILayout() {
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-110)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        
        happinessLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.height.equalTo(18)
        }
        
        freeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(happinessLabel.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: 55, height: 18))
        }
    }
}
