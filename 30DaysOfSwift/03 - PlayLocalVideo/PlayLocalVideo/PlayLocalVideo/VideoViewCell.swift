//
//  VideoViewCell.swift
//  PlayLocalVideo
//
//  Created by QDSG on 2019/9/30.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

struct Video {
    let image: UIImage?
    let title: String
    let source: String
}

protocol VideoViewCellDelegate: NSObjectProtocol {
    func playVideo(cell: VideoViewCell)
}

class VideoViewCell: UITableViewCell {
    
    static let reuseIdentifier = "videoViewCellID"
    
    weak var delegate: VideoViewCellDelegate?
    
    func configure(with video: Video) {
        videoCoverView.image = video.image
        videoTitleLabel.text = video.title
        videoSourceLabel.text = video.source
    }
    
    @IBOutlet weak var videoCoverView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoSourceLabel: UILabel!
    
    @IBAction func play(_ sender: UIButton) {
        delegate?.playVideo(cell: self)
    }
}
