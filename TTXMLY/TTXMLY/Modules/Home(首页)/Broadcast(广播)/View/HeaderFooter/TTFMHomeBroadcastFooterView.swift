//
//  TTFMHomeBroadcastFooterView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/15.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMHomeBroadcastFooterView: UICollectionReusableView {
    static let reuseIdentifier = "homeBroadcastFooterViewID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Constants.Colors.sectionFooter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
