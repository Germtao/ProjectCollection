//
//  TTFMHomeLiveBannerCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import SwiftMessages

private let liveBannerCellID = "homeLiveBannerCellID"

class TTFMHomeLiveBannerCell: UICollectionViewCell {
    static let reuseIdentifier = "homeLiveBannerCellID"
    
    private var bannerList: [TTFMHomeLiveBannerList]?
    
    func configure(with list: [TTFMHomeLiveBannerList]?) {
        guard let list = list else { return }
        bannerList = list
        carouselView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var carouselView: TTCarouselView = {
        let view = TTCarouselView()
        view.delegate = self
        view.dataSource = self
        view.automaticSlidingInterval = 3
        view.isInfinite = true
        view.register(TTCarouselViewCell.self, forCellWithReuseIdentifier: liveBannerCellID)
        return view
    }()
}

extension TTFMHomeLiveBannerCell {
    private func setupUI() {
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.addSubview(carouselView)
        carouselView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension TTFMHomeLiveBannerCell: TTCarouselViewDelegate, TTCarouselViewDataSource {
    func numberOfItems(in carouselView: TTCarouselView) -> Int {
        return bannerList?.count ?? 0
    }
    
    func carouselView(_ carouselView: TTCarouselView, cellForItemAt index: Int) -> TTCarouselViewCell {
        let cell = carouselView.dequeueReusableCell(withReuseIdentifier: liveBannerCellID, for: index)
        if let cover = bannerList?[index].cover {
            cell.imageView?.kf.setImage(with: URL(string: cover))
        }
        return cell
    }
    
    func carouselView(_ carouselView: TTCarouselView, didSelectItemAt index: Int) {
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        
        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
        warning.configureContent(title: "警告", body: "暂时没有点击功能", iconText: iconText)
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
}
