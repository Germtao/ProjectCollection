//
//  ViewController.swift
//  LoginAnimation
//
//  Created by QDSG on 2020/5/9.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var signInBtn: UIButton! {
        didSet {
            signInBtn.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet private weak var signUpBtn: UIButton! {
        didSet {
            signUpBtn.layer.cornerRadius = 5
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

