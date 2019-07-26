//
//  TTListenViewController.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/1.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTListenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "我听"
        view.backgroundColor = UIColor.red
    }
    
    // MARK: - 懒加载
    private lazy var headerView = TTFMListenHeaderView(frame: CGRect(x: 0,
                                                                     y: 0,
                                                                     width: Size.screenW,
                                                                     height: 120))
    private lazy var viewControllers = [TTFMListenSubscribeVC(),
                                        TTFMListenChannelVC(),
                                        TTFMListenRecommendVC()]
    private var titles = ["订阅", "一键听", "推荐"]
    
    private lazy var leftBarBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "message"), for: .normal)
        button.addTarget(self, action: #selector(leftBarButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightBarBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "search"), for: .normal)
        button.addTarget(self, action: #selector(rightBarButtonClicked), for: .touchUpInside)
        return button
    }()
}

extension TTListenViewController {
    private func setupUI() {
        
    }
}

extension TTListenViewController {
    @objc private func leftBarButtonClicked() {
        
    }
    
    @objc private func rightBarButtonClicked() {
        
    }
}
