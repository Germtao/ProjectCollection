//
//  AnimationCell.swift
//  UICollectionViewAnimations
//
//  Created by TT on 2020/5/17.
//  Copyright © 2020 tao Tao. All rights reserved.
//

import UIKit

class AnimationCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AnimationCell"
    static let className = "AnimationCell"
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var backClosure: (() -> Void)?
    
    func prepareCell(_ model: AnimationCellModel) {
        imageView.image = UIImage(named: model.imagePath)
        textView.isScrollEnabled = false
        backBtn.isHidden = true
    }
    
    func handerCellSelected() {
        textView.isScrollEnabled = false
        backBtn.isHidden = false
        superview?.bringSubviewToFront(self)
    }
    
    @IBAction func backBtnDidTapped() {
        backClosure?()
    }

}
