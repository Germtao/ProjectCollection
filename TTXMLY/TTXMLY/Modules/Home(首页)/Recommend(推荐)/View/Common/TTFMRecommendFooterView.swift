//
//  TTFMRecommendFooterView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/5.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMRecommendFooterView: UICollectionReusableView {
    static let reuseIdentifier = "recommendFooterViewID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.sectionFooter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
