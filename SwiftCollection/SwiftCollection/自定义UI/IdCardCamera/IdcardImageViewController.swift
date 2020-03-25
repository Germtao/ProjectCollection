//
//  IdcardImageViewController.swift
//  SwiftCollection
//
//  Created by QDSG on 2020/3/25.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class IdcardImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet private weak var imageView: UIImageView!

    @IBAction private func frontClickAction() {
        let cameraVc = IdCardCameraController(type: .normal)
        cameraVc.delegate = self
        cameraVc.modalPresentationStyle = .fullScreen
        present(cameraVc, animated: true)
    }
    
    @IBAction private func reverseClickAction() {
        let cameraVc = IdCardCameraController(type: .idcardReverse)
        cameraVc.delegate = self
        cameraVc.modalPresentationStyle = .fullScreen
        present(cameraVc, animated: true)
    }
}

extension IdcardImageViewController: IdCardCameraControllerDelegate {
    func idCardCamera(_ vc: IdCardCameraController, didFinishTakePhoto image: UIImage) {
        imageView.image = image
    }
}
