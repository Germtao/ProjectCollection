//
//  IdCardCameraController.swift
//  SwiftCollection
//
//  Created by QDSG on 2020/3/24.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit
import Photos

enum CameraType {
    case normal
    /// 正面 - 头像
    case idcardFront
    /// 反面 - 国徽
    case idcardReverse
    
    var idcardTitle: String {
        switch self {
        case .idcardFront: return "对齐身份证正面并点击拍照"
        case .idcardReverse: return "对齐身份证背面并点击拍照"
        default: return ""
        }
    }
}

protocol IdCardCameraControllerDelegate: NSObjectProtocol {
    func idCardCamera(_ vc: IdCardCameraController, didFinishTakePhoto image: UIImage)
}

class IdCardCameraController: UIViewController {
    
    weak var delegate: IdCardCameraControllerDelegate?
    
    // MARK: - 私有属性
    private var isFlashOn: Bool = false
    private var cameraType: CameraType = .idcardFront
    private var image: UIImage?
    
    // MARK: - 懒加载
    private var device: AVCaptureDevice?
    private var input: AVCaptureDeviceInput?
    
    private lazy var photoOutput = AVCapturePhotoOutput()
    
    private lazy var session = AVCaptureSession()
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.frame = UIScreen.main.bounds
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        return layer
    }()
    
    private lazy var photoBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: (kScreenW - 60) / 2, y: kScreenH - 60 - 40, width: 60, height: 60)
        button.setImage(UIImage(contentsOfFile: resourceBundle().path(forResource: "photo@2x", ofType: "png")!), for: .normal)
        button.setImage(UIImage(contentsOfFile: resourceBundle().path(forResource: "photo@3x", ofType: "png")!), for: .normal)
        button.addTarget(self, action: #selector(shutterCamera(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 32, y: kScreenH - 45 - 40, width: 45, height: 45)
        button.setImage(UIImage(contentsOfFile: resourceBundle().path(forResource: "close", ofType: "png")!), for: .normal)
        button.addTarget(self, action: #selector(closeCamera(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var flashBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: kScreenW - 45 - 32, y: 40, width: 45, height: 45)
        button.setImage(UIImage(contentsOfFile: resourceBundle().path(forResource: "cameraFlash", ofType: "png")!), for: .normal)
        button.addTarget(self, action: #selector(flashOn(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var switchBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: kScreenW - 45 - 32, y: kScreenH - 45 - 40, width: 45, height: 45)
        button.setImage(UIImage(contentsOfFile: resourceBundle().path(forResource: "cameraSwitch", ofType: "png")!), for: .normal)
        button.addTarget(self, action: #selector(switchCamera), for: .touchUpInside)
        return button
    }()
    
    private lazy var floatingView: IdCardFloatingView = {
        let view = IdCardFloatingView(type: self.cameraType)
        view.frame = view.bounds
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: kScreenH - 64, width: kScreenW, height: 64)
        view.backgroundColor = UIColor(red: 20 / 255.0, green: 20 / 255.0, blue: 20 / 255.0, alpha: 1.0)
        view.isHidden = true
        do {
            let remakeBtn = UIButton(type: .custom)
            remakeBtn.setTitle("重拍", for: .normal)
            remakeBtn.setTitleColor(.white, for: .normal)
            remakeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            remakeBtn.titleLabel?.textAlignment = .center
            remakeBtn.addTarget(self, action: #selector(remakePhoto), for: .touchUpInside)
            remakeBtn.frame = CGRect(x: 12, y: 0, width: 64, height: 64)
            view.addSubview(remakeBtn)
        }
        
        do {
           let usePhotoBtn = UIButton(type: .custom)
           usePhotoBtn.setTitle("使用照片", for: .normal)
           usePhotoBtn.setTitleColor(.white, for: .normal)
           usePhotoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
           usePhotoBtn.titleLabel?.textAlignment = .center
           usePhotoBtn.addTarget(self, action: #selector(usePhoto), for: .touchUpInside)
           usePhotoBtn.frame = CGRect(x: kScreenW - 100, y: 0, width: 100, height: 64)
           view.addSubview(usePhotoBtn)
        }
        
        return view
    }()
    
    private lazy var previewImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - 64)
        imgView.contentMode = .scaleAspectFill
        imgView.isHidden = true
        return imgView
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Life Circle
extension IdCardCameraController {
    convenience init(type: CameraType) {
        self.init()
        self.cameraType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
        if cameraPermission() {
            setupCamera()
            setupUI()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let point = CGPoint(x: kBounds.width / 2, y: kBounds.height / 2)
        focus(at: point)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override var prefersStatusBarHidden: Bool { return false }
    
    override var shouldAutorotate: Bool { return false }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { return .portrait }
}

// MARK: - 初始化
extension IdCardCameraController {
    /// 设置UI
    private func setupUI() {
        view.addSubview(photoBtn)
        view.addSubview(closeBtn)
        view.addSubview(flashBtn)
        view.addSubview(switchBtn)
        view.addSubview(bottomView)
        view.addSubview(previewImgView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(focusGesture(_:)))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(subjectAreaDidChange(_:)),
                                               name: .AVCaptureDeviceSubjectAreaDidChange,
                                               object: nil)
    }
    
    /// 设置相机
    private func setupCamera() {
        device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        guard let device = device else { return }
        
        input = try? AVCaptureDeviceInput(device: device)
        guard let input = input else { return }
        
        session.beginConfiguration()
        if session.canSetSessionPreset(.hd1280x720) {
            session.sessionPreset = .hd1280x720
        }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }
        
        if photoOutput.isFlashScene {
            let photoSettings = AVCapturePhotoSettings()
            photoSettings.flashMode = .auto
            photoOutput.photoSettingsForSceneMonitoring = photoSettings
        }
        
        if device.isWhiteBalanceModeSupported(.autoWhiteBalance) {
            device.whiteBalanceMode = .autoWhiteBalance
        }
        
        // 使用self.session，初始化预览层，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
        view.layer.addSublayer(previewLayer)
        session.commitConfiguration()
        
        session.startRunning()
        
        if cameraType != .normal {
            view.addSubview(floatingView)
        }
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension IdCardCameraController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if error != nil {
            print("error= \(error!.localizedDescription)")
        } else {
            guard let photoBuffer = photoSampleBuffer else { return }
            guard let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(
                forJPEGSampleBuffer: photoBuffer,
                previewPhotoSampleBuffer: previewPhotoSampleBuffer) else { return }
            guard let img = UIImage(data: imageData) else { return }
            
            if cameraType != .normal {
                guard let clipImg = img.idcard_clipImage(inRect: floatingView.idcardWindowLayer.frame) else { return }
                image = clipImg
            } else {
                guard let tempImg = img.fixImageOrientation() else { return }
                image = tempImg
            }
            previewImgView.image = image
            
            session.stopRunning()
            
            closeBtn.isHidden = true
            switchBtn.isHidden = true
            photoBtn.isHidden = true
            bottomView.isHidden = false
            previewImgView.isHidden = false
        }
    }
}

// MARK: - Action
extension IdCardCameraController {
    /// 按下拍照
    @objc private func shutterCamera(_ sender: UIButton) {
        guard let _ = photoOutput.connection(with: .video) else { return }
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = isFlashOn ? .on : .off
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    /// 关闭拍照
    @objc private func closeCamera(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    /// 闪光灯
    @objc private func flashOn(_ sender: UIButton) {
        guard let device = device else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if !isFlashOn {
                    device.torchMode = .on
                    isFlashOn = true
                } else {
                    device.torchMode = .off
                    isFlashOn = false
                }
            } catch let error {
                print("torchError: \(error)")
            }
        } else {
            let alert = UIAlertController(title: "提示",
                                          message: "您的设备没有闪光设备，不能提供手电筒功能，请检查",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default)
            alert.addAction(okAction)
            present(alert, animated: false)
        }
    }
    
    /// 重拍
    @objc private func remakePhoto() {
        session.startRunning()
        
        closeBtn.isHidden = false
        switchBtn.isHidden = false
        photoBtn.isHidden = false
        bottomView.isHidden = true
        previewImgView.isHidden = true
    }
    
    /// 使用照片
    @objc private func usePhoto() {
        if let cgImg = image?.cgImage {
            let newImg = UIImage(cgImage: cgImg, scale: 1.0, orientation: .up)
            print(newImg.size)
            delegate?.idCardCamera(self, didFinishTakePhoto: newImg)
        }
        dismiss(animated: true)
    }
    
    /// 焦点手势
    @objc private func focusGesture(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: tap.view)
        focus(at: point)
    }
    
    /// 主区域发生变化
    @objc private func subjectAreaDidChange(_ noti: Notification) {
        // 先进行判断是否支持控制对焦
        if let device = device,
            device.isFocusPointOfInterestSupported &&
                device.isFocusModeSupported(.autoFocus) {
            do {
                try device.lockForConfiguration()
                device.focusMode = .autoFocus
                let point = CGPoint(x: kScreenW / 2, y: kScreenH / 2)
                focus(at: point)
                device.unlockForConfiguration()
            } catch let error {
                print(error)
            }
        }
    }
    
    /// 切换相机
    @objc private func switchCamera() {
        let anim = CATransition()
        anim.duration = 0.5
        anim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        anim.type = CATransitionType(rawValue: "oglFlip")
        
        let newInput: AVCaptureDeviceInput?
        
        if device?.position == .front {
            device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            anim.subtype = .fromLeft
        } else {
            device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            anim.subtype = .fromRight
        }
        
        guard let device = device else { return }
        newInput = try? AVCaptureDeviceInput(device: device)
        guard let newIp = newInput else { return }
        
        previewLayer.add(anim, forKey: nil)
        
        session.beginConfiguration()
        session.removeInput(input!)
        if session.canAddInput(newIp) {
            session.addInput(newIp)
            input = newIp
        } else {
            session.addInput(input!)
        }
        session.commitConfiguration()
    }
}

// MARK: - Helpers
extension IdCardCameraController {
    private func resourceBundle() -> Bundle {
        guard let path = Bundle(for: self.classForCoder).path(forResource: "CameraResource",
                                                              ofType: "bundle") else { return Bundle() }
        return Bundle(path: path)!
    }
    
    /// 是否开启相机权限
    private func cameraPermission() -> Bool {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .restricted, .denied:
            showAlert()
            return false
        default:
            return true
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "请打开相机权限",
                                      message: "请前往设置中允许应用访问您的相机: 设置-隐私-相机",
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "不需要", style: .cancel)
        let sureAction = UIAlertAction(title: "去设置", style: .default) { (_) in
            let setUrl = URL(string: UIApplication.openSettingsURLString)
            if let url = setUrl, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(sureAction)
        
        let rootVc = UIApplication.shared.windows[0].rootViewController
        rootVc?.present(alert, animated: true)
    }
    
    /// 对焦
    private func focus(at point: CGPoint) {
        let size = view.bounds.size
        let focusPoint = CGPoint(x: point.y / size.height, y: 1 - point.x / size.width)
        
        if let device = device {
            do {
                try device.lockForConfiguration()
                if device.isFocusModeSupported(.autoFocus) {
                    device.focusPointOfInterest = focusPoint
                    device.focusMode = .autoFocus
                }
                
                // 曝光
                if device.isExposureModeSupported(.autoExpose) {
                    device.exposurePointOfInterest = focusPoint
                    device.exposureMode = .autoExpose
                }
                device.unlockForConfiguration()
                
            } catch let error {
                print(error)
            }
        }
    }
}
