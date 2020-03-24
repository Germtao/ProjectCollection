//
//  ViewController.swift
//  SwiftCollection
//
//  Created by QDSG on 2020/3/24.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        }
    }
    
    private lazy var titles = [
        ["星星评分"]
    ]
    
    private lazy var headerTitles = [
        "Custom UI"
    ]
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = titles[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0: firtSectionDidSelect(indexPath)
        default: break
        }
    }
}

extension ViewController {
    private func firtSectionDidSelect(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0: pushStarRatingVc()
        default: break
        }
    }
    
    private func pushStarRatingVc() {
        let starRatingVc = StarRatingViewController()
        navigationController?.pushViewController(starRatingVc, animated: true)
    }
}
