//
//  AnimationCellModel.swift
//  UICollectionViewAnimations
//
//  Created by TT on 2020/5/17.
//  Copyright © 2020 tao Tao. All rights reserved.
//

import Foundation

struct AnimationCellModel {
    let imagePath: String
    
    init(imagePath: String?) {
        self.imagePath = imagePath ?? ""
    }
}

struct AnimationCellViewModel {
    let data = [
        AnimationCellModel(imagePath: "1"),
        AnimationCellModel(imagePath: "2"),
        AnimationCellModel(imagePath: "3"),
        AnimationCellModel(imagePath: "4"),
        AnimationCellModel(imagePath: "5")
    ]
}
