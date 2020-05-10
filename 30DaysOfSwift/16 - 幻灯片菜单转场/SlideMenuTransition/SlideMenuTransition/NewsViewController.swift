//
//  NewsViewController.swift
//  SlideMenuTransition
//
//  Created by QDSG on 2020/5/9.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class NewsViewController: BaseViewController {
    
    private let manager = MenuTransitionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Everyday Moments"
        view.backgroundColor = UIColor(red: 0.062, green: 0.062, blue: 0.07, alpha: 1)
    }
    
    private var viewModel = NewsViewModel()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let menuVc = segue.destination as! MenuViewController
        menuVc.currentItem = self.title ?? ""
        menuVc.modalPresentationStyle = .custom
        menuVc.transitioningDelegate = manager
        manager.delegate = self
    }
}

extension NewsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier,
                                                 for: indexPath) as! NewsCell
        cell.configure(with: viewModel.dataSource[indexPath.row])
        return cell
    }
}

extension NewsViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension NewsViewController: MenuTransitionManagerDelegate {
    func dismiss() {
        dismiss(animated: true)
    }
}
