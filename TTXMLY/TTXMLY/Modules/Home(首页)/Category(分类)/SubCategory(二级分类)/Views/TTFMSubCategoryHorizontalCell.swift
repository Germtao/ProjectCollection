//
//  TTFMSubCategoryHorizontalCell.swift
//  TTXMLY
//
//  Created by QDSG on 2021/3/5.
//  Copyright © 2021 unitTao. All rights reserved.
//

import UIKit

class TTFMSubCategoryHorizontalCell: UICollectionViewCell {
    
    static let reuseIdentifier = "TTFMSubCategoryHorizontalCellID"
    static let className = "TTFMSubCategoryHorizontalCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
}
