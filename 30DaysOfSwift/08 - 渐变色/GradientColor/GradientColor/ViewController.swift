//
//  ViewController.swift
//  GradientColor
//
//  Created by QDSG on 2020/5/8.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var defaultColor: UIColor?
    
    private var audioPlayer: AVAudioPlayer?
    
    private let gradientLayer = CAGradientLayer()
    
    private var timer: Timer?
    
    private var backgroundColor: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        didSet {
            guard let color = backgroundColor else { return }
            
            let cgColor1 = UIColor(red: color.blue, green: color.green, blue: 0, alpha: color.alpha).cgColor
            let cgColor2 = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha).cgColor
            
            gradientLayer.colors = [cgColor1, cgColor2]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultColor = view.backgroundColor
    }

    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction private func musicBtnDidTapped() {
        let bgMusic = URL(fileURLWithPath: Bundle.main.path(forResource: "Ecstasy", ofType: "mp3")!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            try audioPlayer = AVAudioPlayer(contentsOf: bgMusic)
            
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { [weak self] _ in
                self?.randomColor()
            })
        }
        
        let redValue = CGFloat(drand48())
        let blueValue =  CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.addSublayer(gradientLayer)
    }
    
    private func randomColor() {
        let redValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        backgroundColor = (redValue, blueValue, greenValue, 1)
    }
}

extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        audioPlayer?.delegate = nil
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        gradientLayer.removeFromSuperlayer()
        view.backgroundColor = defaultColor
    }
}
