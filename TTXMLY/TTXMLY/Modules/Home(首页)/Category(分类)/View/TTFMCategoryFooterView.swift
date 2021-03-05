//
//  TTFMCategoryFooterView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/9.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMCategoryFooterView: UICollectionReusableView {
    static let reuseIdentifier = "categoryFooterViewID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    private func makeUI() {
        backgroundColor = Constants.Colors.sectionFooter
    }
}
