//
//  ViewController.swift
//  StopWatch
//
//  Created by QDSG on 2019/9/29.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 浮点数默认Double类型, 若要使用Float, 需要先声明
    /// 计数
    var counter: Float = 0.0 {
        didSet {
            timeLabel.text = String(format: "%0.1f", counter)
        }
    }
    
    var timer: Timer?
    var isPlay: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // 符合LosslessStringConvertible协议的，
        // 都可以直接初始化一个String对象
        // timeLabel.text = String(counter)
        
        // 改成使用属性观察器监控和响应属性值的变化
        counter = 0.0
        
        setupUI()
    }

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func reset(_ sender: UIButton) {
        reuseTimer()
        isPlay = false
        counter = 0.0
        playButton.isEnabled = true
        pauseButton.isEnabled = false
    }
    
    @IBAction func play(_ sender: UIButton) {
        playButton.isEnabled = false
        pauseButton.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
        isPlay = true
    }
    
    @IBAction func pause(_ sender: UIButton) {
        playButton.isEnabled = true
        pauseButton.isEnabled = false
        
        reuseTimer()
        isPlay = false
    }
    
    @objc private func updateTimer() {
        counter += 0.1
    }
    
    private func reuseTimer() {
        if let tempTimer = timer {
            tempTimer.invalidate()
        }
        timer = nil
    }
}

extension ViewController {
    private func setupUI() {
        pauseButton.setBackgroundImage(UIImage(color: .lightGray),
                                       for: .disabled)
        pauseButton.setBackgroundImage(UIImage(color: .systemGreen),
                                       for: .normal)
        playButton.setBackgroundImage(UIImage(color: .lightGray),
                                      for: .disabled)
        playButton.setBackgroundImage(UIImage(color: .systemBlue),
                                      for: .normal)
        playButton.isEnabled = true
        pauseButton.isEnabled = false
    }
}

