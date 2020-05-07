//
//  YSGVolumeControl.swift
//  SwiftCollection
//
//  Created by QDSG on 2020/4/21.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit
import MediaPlayer

class YSGVolumeControl {
    let changeKey = Notification.Name("AVSystemController_SystemVolumeDidChangeNotification")
    
    var onVolumeChange: ((Float) -> Void)?
    
    lazy var volumeView: MPVolumeView = {
        let view = MPVolumeView()
        view.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        view.alpha = 0.01
        return view
    }()
    
    deinit {
        try? AVAudioSession.sharedInstance().setActive(false)
        NotificationCenter.default.removeObserver(self)
        onVolumeChange = nil
        volumeView.removeFromSuperview()
    }
    
    init(view: UIView, onVolumeChange: ((Float) -> Void)?) {
        self.onVolumeChange = onVolumeChange
        configure(in: view)
        
        try? AVAudioSession.sharedInstance().setActive(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(volumeChanged), name: changeKey, object: nil)
    }
    
    private func configure(in view: UIView) {
        view.addSubview(volumeView)
        view.sendSubviewToBack(volumeView)
    }
    
    @objc private func volumeChanged() {
        let subviews = volumeView.subviews.filter { $0.isKind(of: UISlider.self) }
        guard let slider = subviews.first as? UISlider else { return }
        let volume = AVAudioSession.sharedInstance().outputVolume
        slider.setValue(volume, animated: false)
        onVolumeChange?(volume)
    }
}
