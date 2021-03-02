//
//  TTFMRadioExpandableCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/15.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMRadioExpandableCell: UICollectionViewCell {
    
    func configure(with str: String?) {
        guard let str = str else { return }
        if str.contains(".png") {
            imageView.image = UIImage(named: str)
        } else {
            titleLabel.text = str
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(red: 248/255.0, green: 245/255.0, blue: 246/255.0, alpha: 1)
        contentView.layer.cornerRadius = 2
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(7.5)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.width.height.equalToSuperview()
        }
    }
    
    private lazy var imageView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
}
