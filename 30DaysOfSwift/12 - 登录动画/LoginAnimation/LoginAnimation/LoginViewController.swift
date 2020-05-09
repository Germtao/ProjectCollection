//
//  LoginViewController.swift
//  LoginAnimation
//
//  Created by QDSG on 2020/5/9.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var usernameTF: UITextField! {
        didSet {
            usernameTF.delegate = self
        }
    }
    
    @IBOutlet private weak var passwordTF: UITextField! {
        didSet {
            passwordTF.delegate = self
        }
    }
    
    @IBOutlet private weak var usernameCenterContraint: NSLayoutConstraint!
    @IBOutlet private weak var passwordCenterContraint: NSLayoutConstraint!
    
    @IBOutlet private weak var loginBtn: UIButton! {
        didSet {
            loginBtn.layer.cornerRadius = 5
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        usernameCenterContraint.constant -= view.bounds.width
        passwordCenterContraint.constant -= view.bounds.width
        loginBtn.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.usernameCenterContraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            self.passwordCenterContraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut, animations: {
            self.loginBtn.alpha = 1
        })
    }
    
    @IBAction private func loginBtnDidTapped() {
        let bounds = loginBtn.bounds
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveLinear, animations: {
            self.loginBtn.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.width + 60, height: bounds.height)
            self.loginBtn.isEnabled = false
        }) { _ in
            self.loginBtn.isEnabled = true
        }
    }
    
    @IBAction private func dismissToVc() {
        dismiss(animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
