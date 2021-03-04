//
//  TTFMRecommendLiveCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/8.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMRecommendLiveCell: UICollectionViewCell {
    static let reuseIdentifier = "recommendLiveCellID"
    
    weak var delegate: TTFMRecommendViewCellDelegate?
    
    private var model = TTFMRecommendModel() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    func configure(with model: TTFMRecommendModel?) {
        guard let model = model else { return }
        self.model = model
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    // MARK: - 懒加载
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (Constants.Sizes.screenW - 55) / 3, height: 180)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.alwaysBounceVertical = true
        view.delegate = self
        view.dataSource = self
        view.register(TTFMLiveCell.self, forCellWithReuseIdentifier: TTFMLiveCell.reuseIdentifier)
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

extension TTFMRecommendLiveCell {
    
    private func makeUI() {
        addSubview(collectionView)
        addSubview(changeButton)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-15)
        }
        
        changeButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
    }
    
    @objc private func changeButtonClicked() {
        delegate?.changeButtonClicked(self, model: model)
    }
}

extension TTFMRecommendLiveCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMLiveCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMLiveCell
        cell.configure(with: model.list?[indexPath.item])
        return cell
    }
}

extension TTFMRecommendLiveCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}
