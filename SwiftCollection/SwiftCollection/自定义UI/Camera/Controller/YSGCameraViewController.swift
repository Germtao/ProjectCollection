//
//  YSGCameraViewController.swift
//  SwiftCollection
//
//  Created by QDSG on 2020/4/16.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit
import Photos

class YSGCameraViewController: UIViewController {
    
    var verticalPadding: CGFloat = 30
    var horizontalPadding: CGFloat = 30
    
    private lazy var cameraView = YSGCameraView()
    
    private lazy var cameraBtn = createButton(named: "cameraButton",
                                              highlighted: "cameraButtonHighlighted",
                                              action: #selector(capturePhoto))
    private lazy var closeBtn = createButton(named: "closeButton",
                                             action: #selector(close))
    private lazy var swapBtn = createButton(named: "swapButton",
                                            action: #selector(swapCamera))
    private lazy var flashBtn = createButton(named: "flashAutoIcon",
                                             action: #selector(toggleFlash))
    
    private var volumeControl: YSGVolumeControl?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
}

extension YSGCameraViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkPermission()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override var shouldAutorotate: Bool { return false }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}

extension YSGCameraViewController {
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(rotate), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(cameraView)
        cameraBtn.isEnabled = false
        
        volumeControl = YSGVolumeControl(view: view, onVolumeChange: { _ in
            <#code#>
        })
    }
    
    /// 是否开启相机权限
    private func checkPermission() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .authorized:
            initUI()
        default:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.initUI()
                    } else {
                        self.showAlert()
                    }
                }
            }
        }
    }
    
    private func initUI() {
        view.addSubview(cameraBtn)
        view.addSubview(closeBtn)
        view.addSubview(swapBtn)
        view.addSubview(flashBtn)
        
        cameraView.configureFocus()
        
        layoutUI()
    }
    
    private func layoutUI() {
        let size = view.frame.size
        let cameraSize = cameraBtn.frame.size
        let cameraX = (size.width - cameraSize.width) / 2
        let cameraY = size.height - (cameraSize.height + verticalPadding)
        cameraBtn.frame.origin = CGPoint(x: cameraX, y: cameraY)
        cameraBtn.alpha = 1
        
        let closeSize = closeBtn.frame.size
        let closeX = horizontalPadding
        let closeY = cameraY + (cameraSize.height - closeSize.height) / 2
        closeBtn.frame.origin = CGPoint(x: closeX, y: closeY)
        closeBtn.alpha = 1
        
        let swapSize = swapBtn.frame.size
        let swapX = size.width - swapSize.width - horizontalPadding
        let swapY = closeY
        swapBtn.frame.origin = CGPoint(x: swapX, y: swapY)
        swapBtn.alpha = 1
        
        let flashX = swapX
        let flashY = verticalPadding
        flashBtn.frame.origin = CGPoint(x: flashX, y: flashY)
    }
}

// MARK: - Action
extension YSGCameraViewController {
    @objc private func capturePhoto() {
        guard let ouput = cameraView.imageOutput, let connection = ouput.connection(with: .video) else { return }
        
        if connection.isEnabled {
            cameraBtn.isEnabled = false
            closeBtn.isEnabled = false
            swapBtn.isEnabled = false
            
            cameraView.
        }
    }
    
    @objc private func close() {
        
    }
    
    @objc private func swapCamera() {
        
    }
    
    @objc private func toggleFlash() {
        
    }
}

// MARK: - Helpers
extension YSGCameraViewController {
    private func createButton(named normal: String, highlighted: String = "", action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(YSGCameraManager.image(with: normal), for: .normal)
        button.setImage(YSGCameraManager.image(with: highlighted), for: .highlighted)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.sizeToFit()
        return button
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
}
