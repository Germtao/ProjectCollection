//
//  ViewController.swift
//  AnimationTableView
//
//  Created by QDSG on 2020/5/9.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    private let dataSource = [
        "Personal Life",
        "Buddy Company",
        "#30 days Swift Project",
        "Body movement training",
        "AppKitchen Studio",
        "Project Read",
        "Others",
        "Personal Life",
        "Buddy Company",
        "#30 days Swift Project",
        "Body movement training",
        "AppKitchen Studio",
        "Project Read",
        "Others"
    ]
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        animationTableView()
    }
    
    private func animationTableView() {
        tableView.reloadData()
        
        let visibleCells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        
        for (index, cell) in visibleCells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FirstViewCell.reuseIdentifier,
                                                 for: indexPath) as! FirstViewCell
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = color(forRowAt: indexPath)
    }
    
    private func color(forRowAt indexPath: IndexPath) -> UIColor {
        let rowCount = dataSource.count - 1
        let color = (CGFloat(indexPath.row) / CGFloat(rowCount)) * 0.6
        return UIColor(red: color, green: 0.0, blue: 1.0, alpha: 1.0)
    }
}
