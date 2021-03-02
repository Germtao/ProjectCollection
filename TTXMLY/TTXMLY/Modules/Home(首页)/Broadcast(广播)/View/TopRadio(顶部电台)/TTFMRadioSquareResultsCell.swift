//
//  TTFMRadioSquareResultsCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/15.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

protocol TTFMRadioSquareResultsCellDelegate: NSObjectProtocol {
    func radioSquareResultsCellClicked(urlStr: String, title: String)
}

class TTFMRadioSquareResultsCell: UICollectionViewCell {
    static let reuseIdentifier = "radioSquareResultsCellID"
    
    weak var delegate: TTFMRadioSquareResultsCellDelegate?
    
    private var radioSquareResults: [TTFMRadiosSquareResultsModel]?
    
    func configure(with list: [TTFMRadiosSquareResultsModel]?) {
        guard let list = list else { return }
        radioSquareResults = list
        collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.register(TTFMRadioSquareCell.self, forCellWithReuseIdentifier: TTFMRadioSquareCell.reuseIdentifier)
        return view
    }()
}

extension TTFMRadioSquareResultsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return radioSquareResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRadioSquareCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMRadioSquareCell
        cell.configure(with: radioSquareResults?[indexPath.item])
        return cell
    }
}

extension TTFMRadioSquareResultsCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.Sizes.screenW / 5, height: contentView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uriStr = radioSquareResults?[indexPath.item].uri ?? ""
        let title = radioSquareResults?[indexPath.item].title ?? ""
        let urlStr = Utils.getCategoryId(from: uriStr, key: "api")
        delegate?.radioSquareResultsCellClicked(urlStr: urlStr, title: title)
    }
}
