//
//  TTFMReCommendOneKeyListenCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/8.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMReCommendOneKeyListenCell: UICollectionViewCell {
    static let reuseIdentifier = "recommendOneKeyListenCellID"
    
    private var oneKeyListenList: [TTFMOneKeyListenModel]?
    
    func configure(with list: [TTFMOneKeyListenModel]?) {
        guard let list = list else { return }
        oneKeyListenList = list
        collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (Constants.Sizes.screenW - 45) / 3, height: 120)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.alwaysBounceVertical = true
//        view.delegate = self
        view.dataSource = self
        view.register(TTFMOneKeyListenCell.self,
                      forCellWithReuseIdentifier: TTFMOneKeyListenCell.reuseIdentifier)
        return view
    }()
    
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
}

extension TTFMReCommendOneKeyListenCell {
    
    private func setupUI() {
        addSubview(collectionView)
        addSubview(changeButton)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        changeButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
    }
    
    @objc private func changeButtonClicked() {
        print("TTFMRecommendOneKeyListenCell - 换一批")
    }
}

extension TTFMReCommendOneKeyListenCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return oneKeyListenList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMOneKeyListenCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMOneKeyListenCell
        cell.configure(with: oneKeyListenList?[indexPath.item])
        return cell
    }
}
