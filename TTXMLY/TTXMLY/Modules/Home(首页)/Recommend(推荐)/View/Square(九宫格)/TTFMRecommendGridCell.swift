//
//  TTFMRecommendGridCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/3.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import Kingfisher

class TTFMRecommendGridCell: UICollectionViewCell {
    static let reuseIdentifier = "recommendGridCellID"
    
    func configure(with model: TTFMRecommendSquareModel?) {
        guard let model = model else { return }
        
        if let urlStr = model.coverPath {
            imageView.kf.setImage(with: URL(string: urlStr))
        }
        titleLabel.text = model.title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    private func makeUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(imageView.snp.bottom).offset(5)
        }
    }
    
    private lazy var imageView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(13.0)
        label.textAlignment = .center
        return label
    }()
}
