//
//  TTFMHomeVipHotCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

protocol TTFMHomeVipHotCellDelegate: NSObjectProtocol {
    func vipHotCellDidSelect(with model: TTFMCategoryContents)
}

class TTFMHomeVipHotCell: UITableViewCell {
    static let reuseIdentifier = "homeVipHotCellID"
    
    weak var delegate: TTFMHomeVipHotCellDelegate?
    
    private var hotList: [TTFMCategoryContents]?
    
    func configure(with list: [TTFMCategoryContents]?) {
        guard let list = list else { return }
        hotList = list
        collectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.alwaysBounceVertical = true
        view.delegate = self
        view.dataSource = self
        view.register(TTFMVipHotCell.self, forCellWithReuseIdentifier: TTFMVipHotCell.reuseIdentifier)
        return view
    }()
}

extension TTFMHomeVipHotCell {
    private func setupUI() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalToSuperview()
        }
    }
}

extension TTFMHomeVipHotCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = hotList?.count else { return 0 }
        if count > 3 {
            return 3
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMVipHotCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMVipHotCell
        cell.configure(with: hotList?[indexPath.item])
        return cell
    }
}

extension TTFMHomeVipHotCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Size.screenW - 50) / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = hotList?[indexPath.item] else { return }
        delegate?.vipHotCellDidSelect(with: model)
    }
}
