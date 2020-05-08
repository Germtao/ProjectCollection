//
//  CarouselViewCell.swift
//  CarouselEffect
//
//  Created by QDSG on 2020/5/7.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class CarouselViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var label: UILabel!
    
    var model: Interest? {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        imageView.image = model?.featuredImage
        label.text = model?.title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 5
        clipsToBounds = true
    }
}
