//
//  ViewController.swift
//  GradientColorTableView
//
//  Created by TT on 2020/5/8.
//  Copyright © 2020 tao Tao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let cellId = "cellId"
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 60
            tableView.tableFooterView = UIView()
        }
    }
    
    private let dataSource = [
        "Row 1",
        "Row 2",
        "Row 3",
        "Row 4",
        "Row 5",
        "Row 6",
        "Row 7",
        "Row 8",
        "Row 9",
        "Row 10",
    ]
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 18)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = color(forRowAt: indexPath)
    }
    
    /// 实现颜色梯度渐变
    private func color(forRowAt indexPath: IndexPath) -> UIColor {
        let rowCount = dataSource.count - 1
        let color = (CGFloat(indexPath.row) / CGFloat(rowCount)) * 0.6
        return UIColor(red: 1.0, green: color, blue: 0.0, alpha: 1.0)
    }
}

