//
//  YSGCameraView.swift
//  SwiftCollection
//
//  Created by QDSG on 2020/4/15.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit
import AVFoundation

class YSGCameraView: UIView {

    var session: AVCaptureSession!
    var input: AVCaptureDeviceInput!
    var device: AVCaptureDevice!
    var imageOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    let cameraQueue = DispatchQueue(label: "com.zero.camera.Queue")
    
    var currentPosition: AVCaptureDevice.Position = .back
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = bounds
    }
}

extension YSGCameraView {
    func startSession() {
        cameraQueue.async {
            self.initSession()
            self.session?.startRunning()
        }
    }
    
    func stopSession() {
        cameraQueue.async {
            self.session?.stopRunning()
            self.previewLayer?.removeFromSuperlayer()
            
            self.session = nil
            self.input = nil
            self.imageOutput = nil
            self.previewLayer = nil
            self.device = nil
        }
    }
    
    func configureFocus() {
        if let gestures = gestureRecognizers {
            for gesture in gestures {
                removeGestureRecognizer(gesture)
            }
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(focus(_:)))
        addGestureRecognizer(tap)
    }
    
    func swapCameraInput() {
        guard let session = session, let input = input else { return }
        
        let anim = CATransition()
        anim.duration = 0.5
        anim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        anim.type = CATransitionType(rawValue: "oglFlip")
        
        session.beginConfiguration()
        session.removeInput(input)
        
        if input.device.position == .back {
            currentPosition = .front
            device = cameraWithPosition(currentPosition)
            anim.subtype = .fromRight
        } else {
            currentPosition = .back
            device = cameraWithPosition(currentPosition)
            anim.subtype = .fromLeft
        }
        
        guard let newInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        previewLayer.add(anim, forKey: nil)
        
        if session.canAddInput(newInput) {
            session.addInput(newInput)
            self.input = newInput
        } else {
            session.addInput(self.input)
        }
        
        session.commitConfiguration()
    }
}

extension YSGCameraView {
    private func initSession() {
        session = AVCaptureSession()
        session.sessionPreset = .high
        DispatchQueue.main.async {
            self.initPreview()
        }
    }
    
    private func initPreview() {
        device = cameraWithPosition(currentPosition)
        
        do {
            input = try AVCaptureDeviceInput(device: device)
        } catch let error {
            input = nil
            print("Error: \(error.localizedDescription)")
            return
        }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecJPEG])
        imageOutput = AVCapturePhotoOutput()
        if device.hasFlash {
            do {
                try device.lockForConfiguration()
                settings.flashMode = .auto
                imageOutput.photoSettingsForSceneMonitoring = settings
                device.unlockForConfiguration()
            } catch _ {}
        }
        if session.canAddOutput(imageOutput) {
            session.addOutput(imageOutput)
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = bounds
        layer.addSublayer(previewLayer!)
    }
}

// MARK: - Action
extension YSGCameraView {
    /// 对焦
    @objc private func focus(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: tap.view)
        focusCamera(at: point)
    }
}

// MARK: - Helpers
extension YSGCameraView {
    /// 获取设备当前相机
    private func cameraWithPosition(_ position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: position).devices
        return devices.filter { $0.position == position }.first
    }
    
    /// 对焦
    func focusCamera(at point: CGPoint) {
        guard let device = device, device.isFocusModeSupported(.autoFocus) else { return }
        do {
            try device.lockForConfiguration()
            
            // 焦点在0 ... 1范围内，而不是屏幕像素
            let focusPoint = CGPoint(x: point.x / frame.width, y: point.y / frame.height)
            device.focusPointOfInterest = focusPoint
            device.focusMode = .autoFocus
            device.exposurePointOfInterest = focusPoint
            device.exposureMode = .autoExpose
            device.unlockForConfiguration()
            
        } catch {
            return
        }
    }
}
