//
//  ViewController.swift
//  LimitCharacterInput
//
//  Created by TT on 2020/5/13.
//  Copyright © 2020 tao Tao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var countLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ViewController {
    private func setupNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
}

extension ViewController {
    @objc private func keyboardWillShow(_ noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        guard let keyboardBounds = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else { return }
        let deltaY = keyboardBounds.size.height
        let animations = {
            self.bottomView.transform = CGAffineTransform(translationX: 0, y: -deltaY)
        }
        if duration > 0 {
            UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState, .curveLinear], animations: animations, completion: nil)
        } else {
            animations()
        }
    }
    
    @objc private func keyboardWillHide(_ noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        guard let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else { return }
        let animations = {
            self.bottomView.transform = .identity
        }
        if duration > 0 {
            UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState, .curveLinear], animations: animations, completion: nil)
        } else {
            animations()
        }
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputTextCount = text.count - range.length + self.textView.text.count
        if inputTextCount > 150 {
            return false
        }
        countLabel.text = "\(150 - inputTextCount)"
        return true
    }
}

