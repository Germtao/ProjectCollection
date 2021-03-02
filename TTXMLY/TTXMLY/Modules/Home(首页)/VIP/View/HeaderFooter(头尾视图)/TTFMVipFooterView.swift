//
//  TTFMVipFooterView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMVipFooterView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "vipFooterViewID"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Constants.Colors.sectionFooter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
