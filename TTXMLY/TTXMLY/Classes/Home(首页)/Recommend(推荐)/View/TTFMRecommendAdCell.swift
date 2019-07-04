//
//  TTFMRecommendAdCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/2.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

// MARK: - 广告cell
class TTFMRecommendAdCell: UICollectionViewCell {
    
    static let reuseIdentifier = "recommendAdCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ad_default.jpg")
        view.contentMode = UIView.ContentMode.scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.text = "那些事..."
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "开年会发年终奖呀..."
        return label
    }()
}

extension TTFMRecommendAdCell {
    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-60)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(imageView.snp.bottom)
            make.height.equalTo(30)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}

extension TTFMRecommendAdCell {
    /// 配置cell属性
    func configure(with model: TTFMRecommendAdModel?) {
        guard let model = model else { return }
        titleLabel.text = model.name
        subTitleLabel.text = model.description
    }
}
