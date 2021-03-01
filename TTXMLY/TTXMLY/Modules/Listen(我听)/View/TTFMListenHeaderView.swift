//
//  TTFMListenHeaderView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/26.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMListenHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var downView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.sectionFooter
        return view
    }()
    
    private let titleArr = ["下载", "历史", "已购", "喜欢"]
    private let imageArr = ["下载", "历史", "购物车", "喜欢"]
    private let numArr = ["暂无", "8", "暂无", "25"]
}

extension TTFMListenHeaderView {
    private func setupUI() {
        addSubview(downView)
        downView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
        
        let btnWH = frame.width / 8
        for index in 0..<titleArr.count {
            let btn = UIButton(type: .custom)
            btn.setImage(UIImage(named: imageArr[index]), for: .normal)
            btn.tag = index
            btn.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
            addSubview(btn)
            
            let label = UILabel()
            label.textAlignment = .center
            label.font = TTFont.font(15)
            label.textColor = .gray
            label.text = titleArr[index]
            addSubview(label)
            
            let numLabel = UILabel()
            numLabel.textAlignment = .center
            numLabel.font = TTFont.font(14)
            numLabel.textColor = .gray
            numLabel.text = numArr[index]
            addSubview(numLabel)
            
            btn.snp.makeConstraints { (make) in
                make.left.equalTo(btnWH * (CGFloat(index * 2) + 0.5))
                make.top.equalTo(10)
                make.width.height.equalTo(btnWH)
            }
            
            label.snp.makeConstraints { (make) in
                make.centerX.equalTo(btn)
                make.width.equalTo(btnWH + 20)
                make.top.equalTo(btnWH + 10)
            }
            
            numLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(btn)
                make.width.equalTo(btnWH + 20)
                make.top.equalTo(label.snp.bottom).offset(5)
            }
        }
    }
    
    @objc private func buttonClicked(_ sender: UIButton) {
        print("TTFMListenHeaderView: 点击了\(sender.tag) -\(sender.title(for: .normal) ?? "aaaaaa")")
    }
}
