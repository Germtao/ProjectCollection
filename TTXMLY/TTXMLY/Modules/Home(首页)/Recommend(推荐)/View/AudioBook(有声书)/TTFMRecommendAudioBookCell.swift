//
//  TTFMRecommendAudioBookCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/5.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

// MARK: - 有声书
class TTFMRecommendAudioBookCell: UICollectionViewCell {
    
    static let reuseIdentifier = "recommendAudioBookCellID"
    
    private var recommendList: [TTFMRecommendListModel]?
    
    func configure(with list: [TTFMRecommendListModel]?) {
        recommendList = list
        collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var changeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(Constants.Colors.button, for: .normal)
        button.backgroundColor = Constants.Colors.buttonBg
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.alwaysBounceVertical = true
        view.delegate = self
        view.dataSource = self
        view.register(TTFMAudioBookCell.self,
                      forCellWithReuseIdentifier: TTFMAudioBookCell.reuseIdentifier)
        return view
    }()
}

extension TTFMRecommendAudioBookCell {
    private func setupUI() {
        addSubview(collectionView)
        addSubview(changeButton)
        
        setupUILayout()
    }
    
    private func setupUILayout() {
        collectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-15)
        }
        
        changeButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}

extension TTFMRecommendAudioBookCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMAudioBookCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMAudioBookCell
        cell.configure(with: recommendList?[indexPath.item])
        return cell
    }
}

extension TTFMRecommendAudioBookCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.Sizes.screenW - 30, height: 120)
    }
}
