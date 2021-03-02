//
//  TTFMLiveCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/8.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMLiveCell: UICollectionViewCell {
    static let reuseIdentifier = "liveCellID"
    
    func configure(with model: TTFMRecommendLiveModel?) {
        guard let model = model else { return }
        if model.coverMiddle != nil {
            imageView.kf.setImage(with: URL(string: model.coverMiddle!))
        }
        titleLabel.text = model.nickname
        subTitleLabel.text = model.name
        categoryLabel.text = model.categoryName
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(16)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(12)
        label.textColor = .white
        label.backgroundColor = .orange
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    /// 复制层视图, 播放器动画效果
    private lazy var replicatorLayer = TTReplicatorLayer(frame: CGRect(x: 0,
                                                                       y: 0,
                                                                       width: 2,
                                                                       height: 15))
}

extension TTFMLiveCell {
    private func setupUI() {
        imageView.addSubview(categoryLabel)
        imageView.addSubview(replicatorLayer)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        setupUILayout()
    }
    
    private func setupUILayout() {
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(-5)
            make.size.equalTo(CGSize(width: 30, height: 20))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
            make.height.equalTo(20)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(40)
        }
        
        replicatorLayer.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 20, height: 10))
        }
    }
}
