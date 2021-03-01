//
//  TTFMHomeVipCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMHomeVipCell: UITableViewCell {
    static let reuseIdentifier = "homeVipCellID"
    
    func configure(with model: TTFMCategoryContents?) {
        guard let model = model else { return }
        if model.coverLarge != nil {
            pictureView.kf.setImage(with: URL(string: model.coverLarge!))
        }
        titleLabel.text = model.title
        subTitleLabel.text = model.intro
        tracksLabel.text = "\(model.tracks)集"
        playCountLabel.text = String.transform(from: model.playsCounts)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var pictureView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(17)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(15)
        label.textColor = UIColor.gray
        return label
    }()
    
    /// 播放量
    private lazy var playCountLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(14)
        label.textColor = .gray
        return label
    }()
    
    /// 集数
    private lazy var tracksLabel: UILabel = {
        let label = UILabel()
        label.font = TTFont.font(14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var playCountView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "playCount")
        return imageView
    }()
    
    private lazy var tracksView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "episodeCount")
        return imageView
    }()
}

extension TTFMHomeVipCell {
    private func setupUI() {
        contentView.addSubview(pictureView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(playCountLabel)
        contentView.addSubview(tracksLabel)
        contentView.addSubview(playCountView)
        contentView.addSubview(tracksView)
        
        setupUILayout()
    }
    
    private func setupUILayout() {
        pictureView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(pictureView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(pictureView)
            make.height.equalTo(20)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        playCountView.snp.makeConstraints { (make) in
            make.left.equalTo(subTitleLabel)
            make.bottom.equalToSuperview().offset(-25)
            make.width.height.equalTo(17)
        }
        
        playCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(playCountView.snp.right).offset(5)
            make.bottom.equalTo(playCountView)
            make.width.equalTo(80)
        }
        
        tracksView.snp.makeConstraints { (make) in
            make.left.equalTo(playCountLabel.snp.right).offset(5)
            make.bottom.equalTo(playCountLabel)
            make.width.height.equalTo(20)
        }
        
        tracksLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tracksView.snp.right).offset(5)
            make.bottom.equalTo(tracksView)
            make.width.equalTo(80)
        }
    }
}
