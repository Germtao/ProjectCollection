//
//  TTNavigationController.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/28.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
    }
    
    private func setupNavBar() {
        TTNavigationBar.defaultNavBarBarTintColor = Constants.Colors.navBarBarTint
        TTNavigationBar.defaultNavBarTintColor = Constants.Colors.navBarTint
        TTNavigationBar.defaultNavBarTitleColor = Constants.Colors.black
        TTNavigationBar.defaultShadowImageHidden = true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
