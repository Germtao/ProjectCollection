//
//  TTFMRecommendHeaderCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/2.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

protocol TTFMRecommendHeaderCellDelegate: NSObjectProtocol {
    func headerCellGridBtnClicked(categoryId: String, title: String, url: String)
    func headerCellBannerClicked(url: String)
}

class TTFMRecommendHeaderCell: UICollectionViewCell {
    static let reuseIdentifier = "recommendHeaderCellID"
    
    weak var delegate: TTFMRecommendHeaderCellDelegate?
    
    private var focusModel: TTFMRecommendFocusModel?
    private var squareList: [TTFMRecommendSquareModel]?
    private var newsList: [TTFMRecommendNewsModel]?
    
    func configure(with model: TTFMRecommendFocusModel?) {
        guard let model = model else { return }
        focusModel = model
        // TODO:
    }
    
    func configure(with squareList: [TTFMRecommendSquareModel]?) {
        guard let list = squareList else { return }
        self.squareList = list
        gridView.reloadData()
    }
    
    func configure(with newsList: [TTFMRecommendNewsModel]?) {
        guard let list = newsList else { return }
        self.newsList = list
        gridView.reloadData()
    }
    
    // MARK: - overrid functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - 懒加载
    /// 九宫格分类按钮视图
    private lazy var gridView: UICollectionView = {
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
    
    /// 轮播图
    private lazy var carouselView: TTCarouselView = {
        let view = TTCarouselView()
        view.delegate = self
        view.dataSource = self
        view.automaticSlidingInterval = 3
        view.isInfinite = true
        view.interitemSpacing = 15
        view.transformer = TTCarouselViewTransformer(type: .linear)
        view.register(TTCarouselViewCell.self, forCellWithReuseIdentifier: "carouselViewCellID")
        return view
    }()
}

// MARK: - TTCarouselViewDataSource
extension TTFMRecommendHeaderCell: TTCarouselViewDataSource {
    func numberOfItems(in carouselView: TTCarouselView) -> Int {
        return focusModel?.data?.count ?? 0
    }
    
    func carouselView(_ carouselView: TTCarouselView, cellForItemAt index: Int) -> TTCarouselViewCell {
        let cell = carouselView.dequeueReusableCell(withReuseIdentifier: "carouselViewCellID", for: index)
        cell.imageView?.kf.setImage(with: URL(string: (focusModel?.data?[index].cover)!))
        return cell
    }
}

// MARK: - TTCarouselViewDelegate
extension TTFMRecommendHeaderCell: TTCarouselViewDelegate {
    func carouselView(_ carouselView: TTCarouselView, didSelectItemAt index: Int) {
        let url = focusModel?.data?[index].link ?? ""
        delegate?.headerCellBannerClicked(url: url)
    }
}

// MARK: - UICollectionViewDataSource
extension TTFMRecommendHeaderCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return squareList?.count ?? 0
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendGridCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendGridCell
            cell.configure(with: squareList?[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendNewsCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendNewsCell
            cell.configure(with: newsList)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension TTFMRecommendHeaderCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: (Size.screenW - 5) / 5, height: 80.0)
        } else {
            return CGSize(width: Size.screenW, height: 50.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let string = squareList?[indexPath.item].properties?.uri else {
            let categoryId = "0"
            let title = squareList?[indexPath.item].title ?? ""
            let url = squareList?[indexPath.item].url ?? ""
            delegate?.headerCellGridBtnClicked(categoryId: categoryId, title: title, url: url)
            return
        }
        let categoryId = getUrlCategoryId(url: string)
        let title = squareList?[indexPath.item].title ?? ""
        let url = squareList?[indexPath.item].url ?? ""
        delegate?.headerCellGridBtnClicked(categoryId: categoryId, title: title, url: url)
    }
}

// MARK: - Private Functions
extension TTFMRecommendHeaderCell {
    private func setupUI() {
        addSubview(carouselView)
        addSubview(gridView)
        
        carouselView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(150)
        }
        
        gridView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(carouselView.snp.bottom)
            make.height.equalTo(210)
        }
        
        carouselView.itemSize = CGSize(width: Size.screenW - 60, height: 140)
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
