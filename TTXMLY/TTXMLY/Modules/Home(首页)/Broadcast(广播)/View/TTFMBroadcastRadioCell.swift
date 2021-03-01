//
//  TTFMBroadcastRadioCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/15.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMBroadcastRadioCell: UICollectionViewCell {
    
    static let reuseIdentifier = "broadcastRadioCellID"
    
    func configure(with model: TTFMRadiosModel?) {
        guard let model = model else { return }
        if model.coverLarge != nil {
            imageView.kf.setImage(with: URL(string: model.coverLarge!))
        }
        titleLabel.text = model.name
        subTitleLabel.text = "正在直播: " + (model.programName ?? "")
        countLabel.text = String.transform(from: model.playCount)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    private lazy var imageView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(17)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var countView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "playCount")
        return imageView
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "play"), for: .normal)
        return button
    }()
}

extension TTFMBroadcastRadioCell {
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(countView)
        contentView.addSubview(playButton)
        
        setupUILayout()
    }
    
    private func setupUILayout() {
        imageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(imageView)
            make.height.equalTo(20)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        countView.snp.makeConstraints { (make) in
            make.left.equalTo(subTitleLabel)
            make.bottom.equalToSuperview().offset(-17)
            make.width.height.equalTo(17)
        }
        
        countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(countView.snp.right).offset(5)
            make.size.equalTo(CGSize(width: 200, height: 20))
            make.centerY.equalTo(countView)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
    }
}
