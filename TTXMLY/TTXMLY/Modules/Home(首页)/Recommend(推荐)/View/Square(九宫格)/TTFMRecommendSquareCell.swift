//
//  TTFMRecommendSquareCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/5.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

protocol TTFMRecommendSquareCellDelegate: NSObjectProtocol {
    func squareCellClicked(categoryId: String, title: String, url: String)
}

class TTFMRecommendSquareCell: UICollectionViewCell {
    static let reuseIdentifier = "recommendSquareCellID"
    
    weak var delegate: TTFMRecommendSquareCellDelegate?
    
    private var squareList: [TTFMRecommendSquareModel]?
    
    func configure(with squareList: [TTFMRecommendSquareModel]?) {
        guard let list = squareList else { return }
        self.squareList = list
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
    /// 九宫格分类按钮视图
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.white
        view.delegate = self
        view.dataSource = self
        view.register(TTFMRecommendNewsCell.self, forCellWithReuseIdentifier: TTFMRecommendNewsCell.reuseIdentifier)
        view.register(TTFMRecommendGridCell.self, forCellWithReuseIdentifier: TTFMRecommendGridCell.reuseIdentifier)
        
        return view
    }()
}

// MARK: - UICollectionViewDataSource
extension TTFMRecommendSquareCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return squareList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendGridCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMRecommendGridCell
        cell.configure(with: squareList?[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension TTFMRecommendSquareCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Constants.Sizes.screenW - 5) / 5, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let string = squareList?[indexPath.item].properties?.uri else {
            let categoryId = "0"
            let title = squareList?[indexPath.item].title ?? ""
            let url = squareList?[indexPath.item].url ?? ""
            delegate?.squareCellClicked(categoryId: categoryId, title: title, url: url)
            return
        }
        let categoryId = getUrlCategoryId(url: string)
        let title = squareList?[indexPath.item].title ?? ""
        let url = squareList?[indexPath.item].url ?? ""
        delegate?.squareCellClicked(categoryId: categoryId, title: title, url: url)
    }
}

// MARK: - Private Functions
extension TTFMRecommendSquareCell {
    private func setupUI() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(160)
        }
    }
    
    private func getUrlCategoryId(url: String) -> String {
        // 判断是否有参数
        if !url.contains("?") { return "" }
        
        var paras = [String: Any]()
        // 截取参数
        let split = url.split(separator: "?")
        let string = split[1]
        
        // 判断参数是 单个 还是 多个
        if string.contains("&") {
            // 多个参数, 分割
            let urlComponents = string.split(separator: "&")
            for keyValue in urlComponents {
                // 生成 key/value
                let components = keyValue.split(separator: "=")
                let key = String(components[0])
                let value = String(components[1])
                
                paras[key] = value
            }
        } else {
            // 单个参数
            let components = string.split(separator: "=")
            
            // 判断是否有值
            if components.count == 1 { return "nil" }
            
            let key = String(components[0])
            let value = String(components[1])
            
            paras[key] = value as Any
        }
        
        return paras["category_id"] as! String
    }
}

