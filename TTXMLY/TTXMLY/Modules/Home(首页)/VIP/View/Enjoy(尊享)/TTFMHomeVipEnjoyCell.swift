//
//  TTFMHomeVipEnjoyCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

protocol TTFMHomeVipEnjoyCellDelegate: NSObjectProtocol {
    func homeVipEnjoyCellDidSelect(with model: TTFMCategoryContents)
}

class TTFMHomeVipEnjoyCell: UITableViewCell {
    static let reuseIdentifier = "homeVipEnjoyCellID"
    
    weak var delegate: TTFMHomeVipEnjoyCellDelegate?
    
    private var enjoyList: [TTFMCategoryContents]?
    
    func configure(with list: [TTFMCategoryContents]?) {
        guard let list = list else { return }
        enjoyList = list
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
        view.register(TTFMVipEnjoyCell.self, forCellWithReuseIdentifier: TTFMVipEnjoyCell.reuseIdentifier)
        
        return view
    }()

}

extension TTFMHomeVipEnjoyCell {
    private func setupUI() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalToSuperview()
        }
    }
}

extension TTFMHomeVipEnjoyCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = enjoyList?.count else { return 0 }
        if count > 3 {
            return 3
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMVipEnjoyCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMVipEnjoyCell
        cell.configure(with: enjoyList?[indexPath.item])
        return cell
    }
}

extension TTFMHomeVipEnjoyCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Size.screenW - 50) / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = enjoyList?[indexPath.item] else { return }
        delegate?.homeVipEnjoyCellDidSelect(with: model)
    }
}
