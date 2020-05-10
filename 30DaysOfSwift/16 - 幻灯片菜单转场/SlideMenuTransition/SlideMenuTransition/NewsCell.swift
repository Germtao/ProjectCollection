//
//  NewsCell.swift
//  SlideMenuTransition
//
//  Created by QDSG on 2020/5/9.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let reuseIdentifier = "newsCellId"
    
    @IBOutlet private weak var newsImgView: UIImageView!
    @IBOutlet private weak var avatarView: UIImageView! {
        didSet {
            avatarView.layer.cornerRadius = avatarView.frame.height / 2
            avatarView.layer.masksToBounds = true
        }
    }
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsDescLabel: UILabel!
    
    func configure(with model: NewsModel) {
        newsImgView.image = UIImage(named: model.image)
        avatarView.image = UIImage(named: model.avatar)
        newsTitleLabel.text = model.title
        newsDescLabel.text = model.avatar
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
