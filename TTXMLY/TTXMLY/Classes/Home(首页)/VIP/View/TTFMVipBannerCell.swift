//
//  TTFMVipBannerCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/9.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

private let vipBannerCellID = "vipCarouselCellID"

protocol TTFMVipBannerCellDelegate: NSObjectProtocol {
    func vipBannerCellClicked(url: String)
}

class TTFMVipBannerCell: UITableViewCell {
    static let reuseIdentifier = "vipBannerCellID"
    
    weak var delegate: TTFMVipBannerCellDelegate?
    
    private var vipBannerDatas: [TTFMFocusImagesData]?
    
    func configure(with list: [TTFMFocusImagesData]?) {
        guard let list = list else { return }
        vipBannerDatas = list
        carouselView.reloadData()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    private lazy var carouselView: TTCarouselView = {
        let view = TTCarouselView()
        view.automaticSlidingInterval = 3
        view.isInfinite = true
        view.interitemSpacing = 15
        view.transformer = TTCarouselViewTransformer(type: .coverFlow)
        view.delegate = self
        view.dataSource = self
        view.register(TTCarouselViewCell.self, forCellWithReuseIdentifier: vipBannerCellID)
        return view
    }()
}

extension TTFMVipBannerCell {
    private func setupUI() {
        addSubview(carouselView)
        carouselView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        carouselView.itemSize = CGSize(width: Size.screenW - 60, height: 140)
    }
}

extension TTFMVipBannerCell: TTCarouselViewDataSource, TTCarouselViewDelegate {
    func numberOfItems(in carouselView: TTCarouselView) -> Int {
        return vipBannerDatas?.count ?? 0
    }
    
    func carouselView(_ carouselView: TTCarouselView, cellForItemAt index: Int) -> TTCarouselViewCell {
        let cell = carouselView.dequeueReusableCell(withReuseIdentifier: vipBannerCellID, for: index)
        if let cover = vipBannerDatas?[index].cover {
            cell.imageView?.kf.setImage(with: URL(string: cover))
        }
        return cell
    }
    
    func carouselView(_ carouselView: TTCarouselView, didSelectItemAt index: Int) {
        let url = vipBannerDatas?[index].link ?? ""
        delegate?.vipBannerCellClicked(url: url)
    }
}
