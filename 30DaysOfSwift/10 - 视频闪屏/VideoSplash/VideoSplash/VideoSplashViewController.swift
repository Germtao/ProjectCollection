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
                setMoviePlayer(_contentURL)
            }
        }
    }
    
    var videoFrame: CGRect = .zero
    var startTime: CGFloat = 0
    var duration: CGFloat = 0
    
    var backgroundColor: UIColor = .black {
        didSet {
            view.backgroundColor = backgroundColor
        }
    }
    
    /// 是否有声音
    var sound: Bool = true {
        didSet {
            moviePlayerSoundLevel = sound ? 1.0 : 0.0
        }
    }
    
    var alpha: CGFloat = 1.0 {
        didSet {
            moviePlayer.view.alpha = alpha
        }
    }
    
    var alwaysRepeat: Bool = true {
        didSet {
            if alwaysRepeat {
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(playerItemDidReachEnd),
                                                       name: .AVPlayerItemDidPlayToEndTime,
                                                       object: moviePlayer.player?.currentItem)
            }
        }
    }
    
    var fillMode: ScalingMode = .resizeAspectFill {
        didSet {
            switch fillMode {
            case .resize:
                moviePlayer.videoGravity = .resize
            case .resizeAspect:
                moviePlayer.videoGravity = .resizeAspect
            case .resizeAspectFill:
                moviePlayer.videoGravity = .resizeAspectFill
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moviePlayer.view.frame = videoFrame
        moviePlayer.showsPlaybackControls = false
        view.addSubview(moviePlayer.view)
        view.sendSubviewToBack(moviePlayer.view)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func setMoviePlayer(_ url: URL) {
        URL.cropVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (videoPath, error) in
            guard let path = videoPath else {
                print("crop video error: \(error?.localizedDescription ?? "")")
                return
            }
            
            DispatchQueue.main.async {
                self.moviePlayer.player = AVPlayer(url: path)
                self.moviePlayer.player?.play()
                self.moviePlayer.player?.volume = self.moviePlayerSoundLevel
            }
        }
    }
    
    @objc fileprivate func playerItemDidReachEnd() {
        moviePlayer.player?.seek(to: .zero)
        moviePlayer.player?.play()
    }
}
