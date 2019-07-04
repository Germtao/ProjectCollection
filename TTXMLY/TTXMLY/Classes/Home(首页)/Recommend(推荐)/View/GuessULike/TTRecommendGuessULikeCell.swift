//
//  TTRecommendGuessULikeCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/4.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTRecommendGuessULikeCell: UICollectionViewCell {
    
    private var recommendList: [TTFMRecommendListModel]?
    
    
    // MARK: - 懒加载
    lazy var changeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(Color.button, for: .normal)
        return button
    }()
}
