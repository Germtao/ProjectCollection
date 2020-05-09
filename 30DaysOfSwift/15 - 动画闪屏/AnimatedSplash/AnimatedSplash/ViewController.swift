//
//  ViewController.swift
//  AnimatedSplash
//
//  Created by QDSG on 2020/5/9.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setImageMask()
    }

    @IBOutlet private weak var imageView: UIImageView!
    
    private var mask: CALayer?
}

extension ViewController {
    private func setImageMask() {
        mask = CALayer()
        mask?.contents = UIImage(named: "twitter")?.cgImage
        mask?.contentsGravity = .resizeAspect
        
        mask?.bounds = CGRect(x: 0, y: 0, width: 100, height: 81)
        mask?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        imageView.setNeedsLayout()
        imageView.layoutIfNeeded()
        mask?.position = imageView.center
        
        imageView.layer.mask = mask
        
        animatedMask()
    }
    
    private func animatedMask() {
        let keyFrameAnim = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnim.delegate = self
        keyFrameAnim.duration = 0.6
        keyFrameAnim.beginTime = CACurrentMediaTime() + 0.5
        keyFrameAnim.timingFunctions = [
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut)
        ]
        
        let initalBounds = NSValue(cgRect: mask!.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 90 * 0.9, height: 73 * 0.9))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 1600, height: 1300))
        
        keyFrameAnim.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnim.keyTimes = [0, 0.3, 1]
        
        mask?.add(keyFrameAnim, forKey: "bounds")
    }
}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        imageView.layer.mask = nil
    }
}

