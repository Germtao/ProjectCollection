//
//  TopImageButton.swift
//  TumblrMenu
//
//  Created by TT on 2020/5/16.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

@IBDesignable
class TopImageButton: UIButton {
    
    var style: ButtonImageStyle = .imageTop
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutButton(with: style)
    }
    
}
