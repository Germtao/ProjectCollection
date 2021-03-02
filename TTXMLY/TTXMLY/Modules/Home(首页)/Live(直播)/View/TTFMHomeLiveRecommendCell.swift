//
//  TTFMHomeLiveRecommendCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/11.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMHomeLiveRecommendCell: UICollectionViewCell {
    static let reuseIdentifier = "homeLiveRecommendCellID"
    
    func configure(with model: TTFMLivesModel?) {
        guard let model = model else { return }
        if model.coverMiddle != nil {
            imageView.kf.setImage(with: URL(string: model.coverMiddle!))
        }
        titleLabel.text = model.name
        subTitleLabel.text = model.nickname
        categoryLabel.text = model.categoryName
        let w = (model.categoryName! as NSString).boundingRect(with: CGSize(width: Double(MAXFLOAT), height: 20.0),
                                                               options: .usesLineFragmentOrigin,
                                                               attributes: [NSAttributedString.Key.font: Constants.Fonts.font(12)],
                                                               context: nil).width
        categoryLabel.snp.updateConstraints { (make) in
            make.width.equalTo(w + 8)
        }
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
    
    private lazy var replicatorLayer = TTReplicatorLayer(frame: CGRect(x: 0, y: 0, width: 2, height: 15))
}

extension TTFMHomeLiveRecommendCell {
    private func setupUI() {
        imageView.addSubview(replicatorLayer)
        imageView.addSubview(categoryLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        setupUILayout()
    }
    
    private func setupUILayout() {
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(20)
            make.width.equalTo(30)
        }
        
        replicatorLayer.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 20, height: 10))
        }
    }
}
