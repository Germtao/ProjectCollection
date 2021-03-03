//
//  TTFMRecommendCarouselCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/2.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

protocol TTFMRecommendCarouselCellDelegate: NSObjectProtocol {
    func carouselCellBannerClicked(url: String)
}

// MARK: - 轮播图cell
class TTFMRecommendCarouselCell: UICollectionViewCell {
    static let reuseIdentifier = "recommendCarouselCellID"
    
    weak var delegate: TTFMRecommendCarouselCellDelegate?
    
    private var focusModel: TTFMRecommendListModel?
    
    func configure(with model: TTFMRecommendListModel?) {
        guard let model = model else { return }
        focusModel = model
        carouselView.reloadData()
    }
    
    // MARK: - overrid functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    // MARK: - 懒加载
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
extension TTFMRecommendCarouselCell: TTCarouselViewDataSource {
    func numberOfItems(in carouselView: TTCarouselView) -> Int {
        return focusModel?.data?.count ?? 0
    }
    
    func carouselView(_ carouselView: TTCarouselView, cellForItemAt index: Int) -> TTCarouselViewCell {
        let cell = carouselView.dequeueReusableCell(withReuseIdentifier: "carouselViewCellID", for: index)
        if let urlStr = focusModel?.data?[index].cover {
            cell.imageView?.kf.setImage(with: URL(string: urlStr))
        }
        return cell
    }
}

// MARK: - TTCarouselViewDelegate
extension TTFMRecommendCarouselCell: TTCarouselViewDelegate {
    func carouselView(_ carouselView: TTCarouselView, didSelectItemAt index: Int) {
        guard let url = focusModel?.data?[index].link else { return }
        delegate?.carouselCellBannerClicked(url: url)
    }
}

extension TTFMRecommendCarouselCell {
    private func makeUI() {
        addSubview(carouselView)
        carouselView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(150)
        }
        carouselView.itemSize = CGSize(width: Constants.Sizes.screenW - 60, height: 140)
    }
}
