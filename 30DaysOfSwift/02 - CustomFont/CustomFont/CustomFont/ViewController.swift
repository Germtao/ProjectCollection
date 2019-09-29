//
//  ViewController.swift
//  CustomFont
//
//  Created by QDSG on 2019/9/29.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var fonts = ["Gaspar Regular",
                         "MFJinHei_Noncommercial-Regular",
                         "MFTongXin_Noncommercial-Regular",
                         "MFZhiHei_Noncommercial-Regular"]
    
    private var fontIndex: Int = 0 {
        didSet {
            textView.font = UIFont(name: fonts[fontIndex], size: 16)
        }
    }
    
    private var text: String = "天黑了\n你很忧愁\n你说世界上\n找不到四块五的妞\n行走在凌晨两点的马路上\n你疲倦地拿着半盒黄鹤楼\n你说可怜世间万物\n没有四块五的妞\n怎样了\n你兜儿里只剩五块出头\n人生路长\n你说你想去看没有边际的海洋\n那里可能会有三块五的海景房\n怎样了\n你是否闲事悠悠\n你说花完所有的钱就剩下一块六\n就剩下一块六\n又到了难倒英雄汉的时候\n傍晚的时候\n她的脸庞定格在你心头\n人海茫茫 她可能是你四块五的妞\n幻想着总有一天会出头\n终有人愿意做你四块五的妞\n流浪吧\n在风雨交加的时候\n人海茫茫\n她可能是你四块五的妞\n幻想着总有一天会出头\n终有人愿意做你四块五的妞\n流浪吧\n在风雨交加的时候\n流浪吧\n在风雨交加的时候"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "自定义字体"
        
        setupUI()
    }
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var fontLabel: UILabel!
}

extension ViewController {
    private func setupUI() {
        fontLabel.layer.cornerRadius = 50
        fontLabel.layer.masksToBounds = true
        fontLabel.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeFont))
        fontLabel.addGestureRecognizer(tap)
        
        textView.font = UIFont(name: fonts[fontIndex], size: 16)
        textView.text = text
    }
    
    @objc private func changeFont() {
        fontIndex = (fontIndex + 1) % 4
    }
}
