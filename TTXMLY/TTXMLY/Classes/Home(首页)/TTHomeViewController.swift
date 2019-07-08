//
//  TTHomeViewController.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/1.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
        view.backgroundColor = .white
        
        setupPageStyle()
    }
    
    private func setupPageStyle() {
        var style = TTPageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = true
        style.isShowUnderline = true
        style.titleSelectedColor = .black
        style.titleNormalColor = .gray
        style.underlineColor = .black
        style.isContentViewScrollEnabled = true
        
        let titles = ["推荐", "分类", "VIP", "直播", "广播"]
        let viewControllers = [TTHomeRecommendViewController(),
                               TTHomeCategoryViewController(),
                               TTHomeRecommendViewController(),
                               TTHomeRecommendViewController(),
                               TTHomeRecommendViewController()]
        for vc in viewControllers {
            self.addChild(vc)
        }
        let pageView = TTPageView(frame: CGRect(x: 0,
                                                y: Size.navBarH,
                                                width: Size.screenW,
                                                height: Size.screenH - Size.navBarH - Size.tabBarH),
                                  style: style,
                                  titles: titles,
                                  childViewControllers: viewControllers)
        pageView.contentView.backgroundColor = .red
        view.addSubview(pageView)
    }
}
