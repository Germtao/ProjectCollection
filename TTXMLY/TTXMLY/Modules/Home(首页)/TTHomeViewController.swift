//
//  TTHomeViewController.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/1.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import DNSPageView

class TTHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
        view.backgroundColor = .white
        
        setupPageStyle()
    }
    
    private func setupPageStyle() {
        let style = PageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = .black
        style.titleColor = .gray
        style.bottomLineColor = .black
        style.bottomLineHeight = 2
        
        let titles = ["推荐", "分类", "VIP", "直播", "广播"]
        let viewControllers = [
            TTHomeRecommendViewController(),
            TTHomeCategoryViewController(),
            TTHomeVIPViewController(),
            TTHomeLiveViewController(),
            TTHomeBroadcastViewController()
        ]
        for vc in viewControllers {
            self.addChild(vc)
        }
        let pageView = PageView(frame: CGRect(x: 0,
                                              y: Constants.Sizes.navBarH,
                                              width: Constants.Sizes.screenW,
                                              height: Constants.Sizes.screenH - Constants.Sizes.navBarH - Constants.Sizes.tabBarH),
                                style: style,
                                titles: titles,
                                childViewControllers: viewControllers)
        pageView.contentView.backgroundColor = .white
        view.addSubview(pageView)
    }
}
