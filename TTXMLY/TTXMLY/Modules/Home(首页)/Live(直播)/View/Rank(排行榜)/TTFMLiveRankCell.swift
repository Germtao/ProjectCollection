//
//  TTFMLiveRankCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/11.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMLiveRankCell: UICollectionViewCell {
    static let reuseIdentifer = "liveRankCellID"
    
    func configure(with model: TTFMMultidimensionalRankVosModel?) {
        guard let model = model else { return }
        titleLabel.text = model.dimensionName
        let margin: CGFloat = 50
        if let count = model.ranks?.count {
            for index in 0..<count {
                let x = (margin + 5) * CGFloat(index)
                let imageView = UIImageView(frame: CGRect(x: x, y: 5, width: margin, height: margin))
                imageView.layer.cornerRadius = imageView.frame.width / 2
                imageView.layer.masksToBounds = true
                if let cover = model.ranks?[index].coverSmall {
                    imageView.kf.setImage(with: URL(string: cover))
                }
                mainView.addSubview(imageView)
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
    
    private lazy var mainView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(18)
        return label
    }()
    
    private lazy var arrowLabel: UILabel = {
        let label = UILabel()
        label.text = ">"
        label.textColor = UIColor.lightGray
        return label
    }()
}

extension TTFMLiveRankCell {
    private func setupUI() {
        contentView.addSubview(mainView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowLabel)
        
        setupUILayout()
    }
    
    private func setupUILayout() {
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(180)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
        
        arrowLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
            make.width.height.equalTo(10)
        }
    }
}
