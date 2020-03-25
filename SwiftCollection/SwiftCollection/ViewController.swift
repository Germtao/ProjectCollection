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
        ["星星评分", "身份证相机"],
        ["按钮重复点击"],
    ]
    
    private lazy var headerTitles = [
        "自定义UI",
        "分类"
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
        case 1: secondSectionDidSelect(indexPath)
        default: break
        }
    }
}

extension ViewController {
    private func firtSectionDidSelect(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0: pushStarRatingVc()
        case 1: pushIdCardCameraVc()
        default: break
        }
    }
    
    private func pushStarRatingVc() {
        let starRatingVc = StarRatingViewController()
        navigationController?.pushViewController(starRatingVc, animated: true)
    }
    
    private func pushIdCardCameraVc() {
        let cameraVc = IdcardImageViewController()
        navigationController?.pushViewController(cameraVc, animated: true)
    }
}

extension ViewController {
    private func secondSectionDidSelect(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0: pushCategoryVc()
        default: break
        }
    }
    
    private func pushCategoryVc() {
        let categoryVc = CategoryViewController()
        navigationController?.pushViewController(categoryVc, animated: true)
    }
}
