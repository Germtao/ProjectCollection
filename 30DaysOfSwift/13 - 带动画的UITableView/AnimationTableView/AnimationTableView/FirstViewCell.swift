//
//  FirstViewCell.swift
//  AnimationTableView
//
//  Created by QDSG on 2020/5/9.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class FirstViewCell: UITableViewCell {
    
    static let reuseIdentifier = "firstCellId"
    
    private let gradientLayer = CAGradientLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defaultConfigure()
        setupGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        defaultConfigure()
        setupGradientLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func defaultConfigure() {
        selectionStyle = .none
        textLabel?.textColor = .white
        textLabel?.font = UIFont(name: "Avenir Next", size: 18)
        textLabel?.backgroundColor = .clear
    }
    
    private func setupGradientLayer() {
        gradientLayer.frame = bounds
        
        let cgColor1 = UIColor(white: 1.0, alpha: 0.2).cgColor
        let cgColor2 = UIColor(white: 1.0, alpha: 0.1).cgColor
        let cgColor3 = UIColor.clear.cgColor
        let cgColor4 = UIColor(white: 0.0, alpha: 0.5).cgColor
        
        gradientLayer.colors = [cgColor1, cgColor2, cgColor3, cgColor4]
        gradientLayer.locations = [0.0, 0.04, 0.95, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
