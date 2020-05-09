//
//  ViewController.swift
//  EmojiSlotMachine
//
//  Created by QDSG on 2020/5/9.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var pickerView: UIPickerView! {
        didSet {
            pickerView.delegate = self
            pickerView.dataSource = self
        }
    }
    
    @IBOutlet private weak var goButton: UIButton! {
        didSet {
            goButton.alpha = 0
            goButton.layer.cornerRadius = 5
            goButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet private weak var resultLabel: UILabel!
    
    private let imageArray = ["👻","👸","💩","😘","🍔","🤖","🍟","🐼","🚖","🐷"]
    private var dataSource1 = [Int]()
    private var dataSource2 = [Int]()
    private var dataSource3 = [Int]()
    
    private var amazingFlag: Bool = false
    
    private var bounds: CGRect = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultConfigure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            self.goButton.alpha = 1
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ViewController {
    private func defaultConfigure() {
        bounds = goButton.bounds
        resultLabel.text = ""
        
        for _ in 0...100 {
            dataSource1.append(Int(arc4random() % 10))
            dataSource2.append(Int(arc4random() % 10))
            dataSource3.append(Int(arc4random() % 10))
        }
    }
    
    @IBAction private func amazingButtonDidTapped(_ sender: UIButton) {
        amazingFlag.toggle()
        sender.setTitle(amazingFlag ? "开挂模式" : "常规模式", for: .normal)
    }
    
    @IBAction private func goButtonDidTapped() {
        var index1: Int
        var index2: Int
        var index3: Int
        
        if amazingFlag {
            index1 = Int(arc4random()) % 90 + 3
            index2 = dataSource2.firstIndex(of: dataSource1[index1])!
            index3 = dataSource3.lastIndex(of: dataSource1[index1])!
        } else {
            index1 = Int(arc4random()) % 90 + 3
            index2 = Int(arc4random()) % 90 + 3
            index3 = Int(arc4random()) % 90 + 3
        }
        
        pickerView.selectRow(index1, inComponent: 0, animated: true)
        pickerView.selectRow(index2, inComponent: 1, animated: true)
        pickerView.selectRow(index3, inComponent: 2, animated: true)
        
        let selectIndex1 = dataSource1[pickerView.selectedRow(inComponent: 0)]
        let selectIndex2 = dataSource2[pickerView.selectedRow(inComponent: 1)]
        let selectIndex3 = dataSource3[pickerView.selectedRow(inComponent: 2)]
        
        let bingo = selectIndex1 == selectIndex2 && selectIndex2 == selectIndex3
        
        resultLabel.text = bingo ? "👏👏🥰🥰" : "😭😭💔💔"
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .curveLinear, animations: {
            self.goButton.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width - 20, height: self.bounds.height)
            self.goButton.isEnabled = false
        }) { _ in
            self.goButton.isEnabled = true
        }
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        
        if component == 0 {
            pickerLabel.text = imageArray[dataSource1[row]]
        } else if component == 1 {
            pickerLabel.text = imageArray[dataSource2[row]]
        } else if component == 2 {
            pickerLabel.text = imageArray[dataSource3[row]]
        }
        
        pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 80)
        pickerLabel.textAlignment = .center
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
}

