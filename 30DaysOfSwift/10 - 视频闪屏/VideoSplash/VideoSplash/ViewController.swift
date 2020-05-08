//
//  ViewController.swift
//  VideoSplash
//
//  Created by QDSG on 2020/5/8.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class ViewController: VideoSplashViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoBackground()
    }

    @IBOutlet private weak var signInBtn: UIButton! {
        didSet {
            signInBtn.layer.cornerRadius = 4
        }
    }
    
    @IBOutlet private weak var signUpBtn: UIButton! {
        didSet {
            signUpBtn.layer.cornerRadius = 4
        }
    }
    
    private func setupVideoBackground() {
        
        guard let path = Bundle.main.path(forResource: "moments", ofType: "mp4") else { return }
        
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        alpha = 0.8
        contentURL = URL(fileURLWithPath: path)
    }
}

