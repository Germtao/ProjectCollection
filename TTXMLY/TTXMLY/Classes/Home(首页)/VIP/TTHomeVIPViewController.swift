//
//  TTHomeVIPViewController.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/9.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTHomeVIPViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    // MARK: - 懒加载
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.purple
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = UIColor.white
        view.separatorStyle = .none
        view.delegate = self
        view.dataSource = self
        view.register(TTFMVipBannerCell.self, forCellReuseIdentifier: TTFMVipBannerCell.reuseIdentifier)
        return view
    }()
    
    private lazy var viewModel = TTFMHomeVipViewModel()
}

extension TTHomeVIPViewController {
    private func setupUI() {
        view.addSubview(view)
        
        tableView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(Size.screenW)
            make.height.equalTo(Size.screenH - Size.navBarH - Size.tabBarH)
        }
    }
    
    private func loadData() {
        viewModel.updateDataHandler = { [unowned self] in
            self.tableView.reloadData()
        }
        viewModel.refreshData()
    }
}

extension TTHomeVIPViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categoryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case TTFMVipCellSecionType.banner.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: TTFMVipBannerCell.reuseIdentifier,
                                                     for: indexPath) as! TTFMVipBannerCell
            cell.configure(with: viewModel.focusImages)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension TTHomeVIPViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeader(in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.heightForFooter(in: section)
    }
}
