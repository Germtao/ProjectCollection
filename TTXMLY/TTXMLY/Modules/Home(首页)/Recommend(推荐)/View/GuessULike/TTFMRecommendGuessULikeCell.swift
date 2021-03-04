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

class TTFMRecommendGuessULikeCell: UICollectionViewCell {
    
    static let reuseIdentifier = "recommendGuessULikeCellID"
    
    weak var delegate: TTFMRecommendViewCellDelegate?
    
    private var model = TTFMRecommendModel() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    func configure(with model: TTFMRecommendModel?) {
        guard let model = model else { return }
        self.model = model
        changeButton.isHidden = model.list?.isEmpty == true
    }
    
    // MARK: - override functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    // MARK: - 懒加载
    /// 换一批按钮
    private lazy var changeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(Constants.Colors.button, for: .normal)
        button.backgroundColor = Constants.Colors.buttonBg
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(changeButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (Constants.Sizes.screenW - 55) / 3, height: 180)
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
        return model.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMGuessULikeCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMGuessULikeCell
        cell.configure(with: model.list?[indexPath.item])
        return cell
    }
}

extension TTFMRecommendGuessULikeCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = model.list?[indexPath.item] else { return }
        
        delegate?.recommendGuessULikeCellClicked(model: model)
    }
}

extension TTFMRecommendGuessULikeCell {
    
    /// 设置UI和布局
    private func makeUI() {
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
        delegate?.changeButtonClicked(self, model: model)
    }
}
