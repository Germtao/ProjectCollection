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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
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
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: Constants.Sizes.screenW - 30, height: 120)
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
    private func makeUI() {
        addSubview(collectionView)
        addSubview(changeButton)
        
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
    
    @objc private func changeButtonClicked() {
        delegate?.changeButtonClicked(self, model: model)
    }
}

extension TTFMRecommendAudioBookCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMAudioBookCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMAudioBookCell
        cell.configure(with: model.list?[indexPath.item])
        return cell
    }
}

extension TTFMRecommendAudioBookCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
