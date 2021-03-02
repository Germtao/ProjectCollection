//
//  TTFMVipCategoryButtonCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMVipCategoryButtonCell: UICollectionViewCell {
    static let reuseIdentifier = "vipCategoryButtonCellID"
    
    func configure(with model: TTFMCategoryButtonModel?) {
        guard let model = model else { return }
        if model.coverPath != nil {
            imageView.kf.setImage(with: URL(string: model.coverPath!))
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(13)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageView = UIImageView()
    
    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
    }
}
