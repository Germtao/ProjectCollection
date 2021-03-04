//
//  TTFMRecommendViewCellDelegate.swift
//  TTXMLY
//
//  Created by QDSG on 2021/3/4.
//  Copyright © 2021 unitTao. All rights reserved.
//

import UIKit

protocol TTFMRecommendViewCellDelegate: NSObjectProtocol {
    func changeButtonClicked(_ cell: UICollectionViewCell, model: TTFMRecommendModel)
    func recommendGuessULikeCellClicked(model: TTFMRecommendListModel)
}
