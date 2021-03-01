//
//  TTFMOneKeyListenCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/8.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMOneKeyListenCell: UICollectionViewCell {
    static let reuseIdentifier = "oneKeyListenCellID"
    
    func configure(with model: TTFMOneKeyListenModel?) {
        guard let model = model else { return }
        if model.coverRound != nil {
            imageView.kf.setImage(with: URL(string: model.coverRound!))
        }
        titleLabel.text = model.channelName
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
        label.font = TTFont.font(15)
        label.textAlignment = .center
        return label
    }()
}

extension TTFMOneKeyListenCell {
    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
    }
}
