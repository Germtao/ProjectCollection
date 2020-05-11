//
//  MenuViewController.swift
//  SlideMenuTransition
//
//  Created by TT on 2020/5/10.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {
    
    var handlerClosure: ((String) -> Void)?
    
    private var menuItems = [
        "Everyday Moments",
        "Popular",
        "Editors",
        "Upcoming",
        "Fresh",
        "Stock-photos",
        "Trending"
    ]
    
    var currentItem = "Everyday Moments" {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.109, green: 0.114, blue: 0.128, alpha: 1)
    }
}

extension MenuViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseIdentifier,
                                                 for: indexPath) as! MenuCell
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = (menuItems[indexPath.row] == currentItem) ? UIColor.white : UIColor.gray
        return cell
    }
}

extension MenuViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        currentItem = menuItems[indexPath.row]
        handlerClosure?(currentItem)
        dismiss(animated: true)
    }
}
