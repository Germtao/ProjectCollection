//
//  TTFMHomeLiveHeaderView.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMHomeLiveHeaderView: UICollectionReusableView {
    static let reuseIdentifer = "homeLiveHeaderViewID"
    
    private lazy var buttonArr = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.button
        return view
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("更多 >", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = Constants.Fonts.font(15)
        button.addTarget(self, action: #selector(moreButtonClicked), for: .touchUpInside)
        return button
    }()
}

extension TTFMHomeLiveHeaderView {
    private func setupUI() {
        createPageButton()
        addSubview(moreButton)
        addSubview(lineView)
        moreButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(2.5)
            make.size.equalTo(CGSize(width: 50, height: 25))
        }
    }
    
    private func createPageButton() {
        let titleArr = ["热门", "情感", "有声", "新秀", "二次元"]
        let margin: CGFloat = 50
        for index in 0..<titleArr.count {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: margin * CGFloat(index), y: 2.5, width: margin, height: 25)
            button.setTitle(titleArr[index], for: .normal)
            button.titleLabel?.font = Constants.Fonts.font(15)
            button.tag = 1000 + index
            if button.tag == 1000 {
                button.setTitleColor(Constants.Colors.button, for: .normal)
                lineView.frame = CGRect(x: 12.5, y: 30, width: margin / 2, height: 2)
            } else {
                button.setTitleColor(.lightGray, for: .normal)
            }
            buttonArr.append(button)
            button.addTarget(self, action: #selector(pageButtonClicked(_:)), for: .touchUpInside)
            addSubview(button)
        }
    }
}

extension TTFMHomeLiveHeaderView {
    @objc private func moreButtonClicked() {
        
    }
    
    @objc private func pageButtonClicked(_ sender: UIButton) {
        
    }
}
