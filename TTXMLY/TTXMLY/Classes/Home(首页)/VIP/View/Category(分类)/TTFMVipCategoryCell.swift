//
//  TTFMVipCategoryCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

protocol TTFMVipCategoryCellDelegate: NSObjectProtocol {
    func categoryCellDidSelect(id: String, url: String, title: String)
}

class TTFMVipCategoryCell: UITableViewCell {
    static let reuseIdentifier = "vipCategoryCellID"
    
    weak var delegate: TTFMVipCategoryCellDelegate?
    
    private var categoryBtnList: [TTFMCategoryButtonModel]?
    
    func configure(with list: [TTFMCategoryButtonModel]?) {
        guard let list = list else { return }
        categoryBtnList = list
        collectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        layout.itemSize = CGSize(width: Size.screenW / 5, height: 80)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.contentSize = CGSize(width: Size.screenW, height: 80)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.register(TTFMVipCategoryButtonCell.self, forCellWithReuseIdentifier: TTFMVipCategoryButtonCell.reuseIdentifier)
        return view
    }()
}

extension TTFMVipCategoryCell {
    private func setupUI() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension TTFMVipCategoryCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryBtnList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMVipCategoryButtonCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMVipCategoryButtonCell
        cell.configure(with: categoryBtnList?[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let str = categoryBtnList?[indexPath.item].properties?.uri else {
            let id = "0"
            let url = categoryBtnList?[indexPath.item].url ?? ""
            let title = categoryBtnList?[indexPath.item].title ?? ""
            delegate?.categoryCellDidSelect(id: id, url: url, title: title)
            return
        }
        
        let id = Utils.getCategoryId(from: str, key: "category_id")
        let url = categoryBtnList?[indexPath.item].url ?? ""
        let title = categoryBtnList?[indexPath.item].title ?? ""
        delegate?.categoryCellDidSelect(id: id, url: url, title: title)
    }
}
