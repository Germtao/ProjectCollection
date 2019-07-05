//
//  TTFMRecommendGuessULikeCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/4.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

protocol TTFMRecommendGuessULikeCellDelegate: NSObjectProtocol {
    func recommendGuessULikeCellClicked(model: TTFMRecommendListModel)
}

class TTFMRecommendGuessULikeCell: UICollectionViewCell {
    
    static let reuseIdentifier = "recommendGuessULikeCellID"
    
    weak var delegate: TTFMRecommendGuessULikeCellDelegate?
    
    private var recommendList: [TTFMRecommendListModel]?
    
    func configure(with list: [TTFMRecommendListModel]?) {
        recommendList = list
        collectionView.reloadData()
    }
    
    // MARK: - override functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    // MARK: - 懒加载
    /// 换一批按钮
    private lazy var changeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(Color.button, for: .normal)
        button.backgroundColor = Color.buttonBg
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(changeButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.alwaysBounceVertical = true
        view.delegate = self
        view.dataSource = self
        view.register(TTFMGuessULikeCell.self, forCellWithReuseIdentifier: TTFMGuessULikeCell.reuseIdentifier)
        return view
    }()
}

extension TTFMRecommendGuessULikeCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMGuessULikeCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMGuessULikeCell
        cell.configure(with: recommendList?[indexPath.item])
        return cell
    }
}

extension TTFMRecommendGuessULikeCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.recommendGuessULikeCellClicked(model: (recommendList?[indexPath.item])!)
    }
    
    /// 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    /// 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    /// 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    /// item 尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Size.screenW - 55) / 3, height: 180)
    }
}

extension TTFMRecommendGuessULikeCell {
    
    /// 设置UI和布局
    private func setupUI() {
        addSubview(changeButton)
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-15)
        }
        
        changeButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
    }
    
    @objc private func changeButtonClicked() {
        TTFMRecommendProvider.request(.changeGuessULikeList) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<TTFMRecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.recommendList = mappedObject as? [TTFMRecommendListModel]
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
