//
//  VideoSplashViewController.swift
//  VideoSplash
//
//  Created by QDSG on 2020/5/8.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

public enum ScalingMode {
    case resize
    case resizeAspect
    case resizeAspectFill
}

class VideoSplashViewController: UIViewController {
    
    private let moviePlayer = AVPlayerViewController()
    
    private var moviePlayerSoundLevel: Float = 1.0
    
    var contentURL: URL? {
        didSet {
            if let _contentURL = contentURL {
                
            }
        }
    }
    
    var videoFrame = CGRect()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
