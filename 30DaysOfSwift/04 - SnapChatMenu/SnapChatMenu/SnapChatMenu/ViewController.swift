//
//  ViewController.swift
//  SnapChatMenu
//
//  Created by QDSG on 2019/9/30.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: width * 3, height: scrollView.bounds.height)
        scrollView.contentOffset = CGPoint(x: width, y: 0)
    }
}

extension ViewController {
    private func setupUI() {
        setLeftView()
        setCenterView()
        setRightView()
    }
    
    private func setLeftView() {
        let leftView = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: width,
                                            height: scrollView.bounds.height))
        let imageView = UIImageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: leftView.bounds.width,
                                                  height: leftView.bounds.height))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "leftImage")
        leftView.addSubview(imageView)
        scrollView.addSubview(leftView)
    }
    
    private func setCenterView() {
        let cameraVc = storyboard!.instantiateViewController(withIdentifier: "cameraVcId") as! CameraViewController
        cameraVc.view.frame = CGRect(x: width,
                                     y: 0,
                                     width: width,
                                     height: scrollView.bounds.height)
        scrollView.addSubview(cameraVc.view)
    }
    
    private func setRightView() {
        let rightView = UIView(frame: CGRect(x: width * 2,
                                             y: 0,
                                             width: width,
                                             height: scrollView.bounds.height))
        let imageView = UIImageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: rightView.bounds.width,
                                                  height: rightView.bounds.height))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "rightImage")
        rightView.addSubview(imageView)
        scrollView.addSubview(rightView)
    }
}
