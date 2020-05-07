//
//  CameraViewController.swift
//  SnapChatMenu
//
//  Created by QDSG on 2019/9/30.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var session: AVCaptureSession?
    private var output: AVCapturePhotoOutput?
    
    private var didTakePhoto: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initCamera()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = view.bounds
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        didPressedTakeAnother()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension CameraViewController {
    /// 初始化相机
    private func initCamera() {
        session = AVCaptureSession()
        session?.sessionPreset = .hd1920x1080
        var backCamera: AVCaptureDevice
        if #available(iOS 10.0, *) {
            backCamera = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first!
        } else {
            backCamera = AVCaptureDevice.devices().first!
        }
        var error: Error?
        var input: AVCaptureDeviceInput!
        
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 {
            error = error1
            input = nil
        }
        
        if error == nil && session?.canAddInput(input) != nil {
            session?.addInput(input)
            
            output = AVCapturePhotoOutput()
            
            if let tempOutput = output, session?.canAddOutput(tempOutput) != nil {
                session?.addOutput(tempOutput)
                if let tempSession = session {
                    previewLayer = AVCaptureVideoPreviewLayer(session: tempSession)
                    previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
                    previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                    view.layer.addSublayer(previewLayer!)
                    tempSession.startRunning()
                }
            }
        }
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    private func didPressedTakeAnother() {
        if didTakePhoto {
            imageView.isHidden = true
            didTakePhoto = false
        } else {
            session?.startRunning()
            didTakePhoto = true
            didPressedTakePhoto()
        }
    }
    
    private func didPressedTakePhoto() {
        if let videoConnection = output?.connection(with: .video) {
            videoConnection.videoOrientation = .portrait
            output?.capturePhoto(with: AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg]), delegate: self)
            
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if previewPhotoSampleBuffer != nil {
        }
        
    }
}
