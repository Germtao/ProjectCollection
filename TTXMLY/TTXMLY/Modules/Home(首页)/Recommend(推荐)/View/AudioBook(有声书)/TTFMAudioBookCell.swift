//
//  TTFMAudioBookCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/5.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMAudioBookCell: UICollectionViewCell {
    static let reuseIdentifier = "audioBookCellID"
    
    func configure(with model: TTFMRecommendListModel?) {
        guard let model = model else { return }
        if model.pic != nil {
            pictureView.kf.setImage(with: URL(string: model.pic!))
        }
        
        if model.coverPath != nil {
            pictureView.kf.setImage(with: URL(string: model.coverPath!))
        }
        
        titleLabel.text = model.title
        subLabel.text = model.subtitle
        
        endLabel.snp.updateConstraints { (make) in
            make.width.equalTo(model.isPaid ? 30 : 0)
        }
        titleLabel.snp.updateConstraints { (make) in
            make.left.equalTo(endLabel.snp.right)
        }
        
        episodeCountLabel.text = "\(model.tracksCount)集"
        playCountLabel.text = String.transform(from: model.playsCount)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    lazy var pictureView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(17)
        return label
    }()
    
    /// 是否完结label
    private lazy var endLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(13)
        label.textColor = .white
        label.backgroundColor = Constants.Colors.endLabel
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.text = "完结"
        return label
    }()
    
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(15)
        label.textColor = .gray
        label.text = "说服力的积分乐"
        return label
    }()
    
    /// 播放量label
    private lazy var playCountLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(14)
        label.textColor = .gray
        label.text = "> 2.5亿 2019集"
        return label
    }()
    
    /// 集数label
    private lazy var episodeCountLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(14)
        label.textColor = .gray
        return label
    }()
    
    /// 播放量图片
    private lazy var playCountView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "playCount")
        return imageView
    }()
    
    /// 集数图片
    private lazy var episodeCountView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "episodeCount")
        return imageView
    }()
}

extension TTFMAudioBookCell {
    private func setupUI() {
        addSubview(pictureView)
        addSubview(titleLabel)
        addSubview(endLabel)
        addSubview(subLabel)
        addSubview(playCountLabel)
        addSubview(playCountView)
        addSubview(episodeCountLabel)
        addSubview(episodeCountView)
        
        setupUILayout()
    }
    
    private func setupUILayout() {
        pictureView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
        }
        
        endLabel.snp.makeConstraints { (make) in
            make.left.equalTo(pictureView.snp.right).offset(10)
            make.top.equalTo(pictureView).offset(2)
            make.size.equalTo(CGSize(width: 30, height: 16))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(endLabel.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(pictureView)
            make.height.equalTo(20)
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.right.height.equalTo(titleLabel)
            make.left.equalTo(pictureView.snp.right).offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        playCountView.snp.makeConstraints { (make) in
            make.left.equalTo(subLabel)
            make.bottom.equalToSuperview().offset(-25)
            make.size.equalTo(CGSize(width: 17, height: 17))
        }
        
        playCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(playCountView.snp.right).offset(5)
            make.bottom.equalTo(playCountView)
            make.width.equalTo(60)
        }
        
        episodeCountView.snp.makeConstraints { (make) in
            make.left.equalTo(playCountLabel.snp.right).offset(5)
            make.bottom.equalTo(playCountLabel)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        episodeCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(episodeCountView.snp.right).offset(5)
            make.bottom.equalTo(episodeCountView)
            make.width.equalTo(80)
        }
    }
}
