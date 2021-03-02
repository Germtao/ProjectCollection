//
//  TTFMHomeLiveCategoryCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/11.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMHomeLiveCategoryCell: UICollectionViewCell {
    static let reuseIdentifier = "homeLiveCategoryCellID"
    
    private let images = ["http://fdfs.xmcdn.com/group45/M08/74/91/wKgKlFtVs-iBg01bAAAmze4KwRQ177.png",
                          "http://fdfs.xmcdn.com/group48/M0B/D9/96/wKgKlVtVs9-TQYseAAAsVyb1apo685.png",
                          "http://fdfs.xmcdn.com/group48/M0B/D9/92/wKgKlVtVs9SwvFI6AAAdwAr5vEE640.png",
                          "http://fdfs.xmcdn.com/group48/M02/63/E3/wKgKnFtW37mR9fH7AAAcl17u2wA113.png",
                          "http://fdfs.xmcdn.com/group46/M09/8A/98/wKgKlltVs3-gubjFAAAxXboXKFE462.png"]
    private let titles = ["温暖男声", "心动女神", "唱将达人", "情感治愈", "直播圈子"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (Constants.Sizes.screenW - 30) / 5, height: 90)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.register(TTFMLiveCategoryCell.self, forCellWithReuseIdentifier: TTFMLiveCategoryCell.reuseIdentifier)
        return view
    }()
}

extension TTFMHomeLiveCategoryCell {
    private func setupUI() {
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(Constants.Sizes.screenW - 30)
            make.height.equalTo(90)
        }
    }
}

extension TTFMHomeLiveCategoryCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMLiveCategoryCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMLiveCategoryCell
        cell.configure(imageName: images[indexPath.item], title: titles[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
