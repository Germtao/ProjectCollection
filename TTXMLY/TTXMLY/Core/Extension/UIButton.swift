//
//  UIButton.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/27.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

extension UIButton {
    /// 导航栏button
    static func buttonForBarItem(target: Any?, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.imageView?.contentMode = .center
        button.isHidden = true
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
}
