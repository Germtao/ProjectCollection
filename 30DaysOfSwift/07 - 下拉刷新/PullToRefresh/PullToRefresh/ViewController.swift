//
//  ViewController.swift
//  PullToRefresh
//
//  Created by QDSG on 2020/5/8.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let cellId = "cellId"
    
    private var index = 0
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.backgroundColor = UIColor(red: 0.113, green: 0.113, blue: 0.145, alpha: 1)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        control.attributedTitle = NSAttributedString(string: "上次更新时间 \(Date())", attributes: attributes)
        control.tintColor = .white
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return control
    }()
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = UIColor(red: 0.092, green: 0.096, blue: 0.116, alpha: 1.0)
            tableView.refreshControl = refreshControl
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 60
        }
    }
    
    private let favoriteEmoji = [
        "🤗🤗🤗🤗🤗",
        "😅😅😅😅😅",
        "😆😆😆😆😆"
    ]
    private let newFavoriteEmoji = [
        "🏃🏃🏃🏃🏃",
        "💩💩💩💩💩",
        "👸👸👸👸👸",
        "🤗🤗🤗🤗🤗",
        "😅😅😅😅😅",
        "😆😆😆😆😆"
    ]
    
    private var emojiData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }

    private func setupData() {
        emojiData = favoriteEmoji
    }
    
    @objc private func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.emojiData = [self.newFavoriteEmoji, self.favoriteEmoji][self.index]
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.index = (self.index + 1) % 2
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = emojiData[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .systemFont(ofSize: 50)
        cell.selectionStyle = .none
        
        return cell
    }
}
