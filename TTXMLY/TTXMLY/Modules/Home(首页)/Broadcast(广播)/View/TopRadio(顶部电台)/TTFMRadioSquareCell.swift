//
//  TTFMRadioSquareCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/15.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMRadioSquareCell: UICollectionViewCell {
    static let reuseIdentifier = "radioSquareCellID"
    
    func configure(with model: TTFMRadiosSquareResultsModel?) {
        guard let model = model else { return }
        if model.icon != nil {
            imageView.kf.setImage(with: URL(string: model.icon!))
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
        label.font = Constants.Fonts.font(13)
        label.textAlignment = .center
        return label
    }()
}

extension TTFMRadioSquareCell {
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
    }
}
