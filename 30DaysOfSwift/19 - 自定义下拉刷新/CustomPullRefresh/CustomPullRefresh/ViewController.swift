//
//  ViewController.swift
//  CustomPullRefresh
//
//  Created by TT on 2020/5/13.
//  Copyright © 2020 tao Tao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let reuseIdentifier = "cellID"
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
            tableView.tableFooterView = UIView()
        }
    }
    
    var refreshControl: UIRefreshControl!
    var customView: UIView!
    var timer: Timer?
    
    var labels: Array<UILabel> = []
    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    var dataArray: Array<String> = ["😂", "🤗", "😳", "😌", "😊"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ViewController {
    func setupUI() {
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .clear
        tableView.addSubview(refreshControl)
        
        loadCustomRefreshContents()
    }
    
    func loadCustomRefreshContents() {
        guard let RefreshContents = Bundle.main.loadNibNamed("RefreshContents", owner: self, options: nil) else { return }
        
        customView = RefreshContents[0] as? UIView
        customView.frame = refreshControl.bounds
        
        for i in 0..<customView.subviews.count {
            labels.append(customView.viewWithTag(i + 1) as! UILabel)
        }
        
        refreshControl.addSubview(customView)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = dataArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Apple Color Emoji", size: 40)
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
}

extension ViewController: UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing {
            if !isAnimating {
                beginRefresh()
                doSomething()
            }
        }
    }
}

extension ViewController {
    func doSomething() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] _ in
            self?.endedOfWork()
        })
    }
    
    private func endedOfWork() {
        refreshControl.endRefreshing()
        timer?.invalidate()
        timer = nil
    }
    
    private func getNextColor() -> UIColor {
        let colors: [UIColor] = [.magenta, .brown, .yellow, .red, .green, .blue, .orange]
        if currentColorIndex == colors.count {
            currentColorIndex = 0
        }
        
        let color = colors[currentColorIndex]
        currentColorIndex += 1
        return color
    }
    
    func beginRefresh() {
        isAnimating = true
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
            self.labels[self.currentLabelIndex].transform = CGAffineTransform(rotationAngle: .pi / 4)
            self.labels[self.currentLabelIndex].textColor = self.getNextColor()
        }) { _ in
            UIView.animate(withDuration: 0.05, delay: 0.0, options: .curveLinear, animations: {
                self.labels[self.currentLabelIndex].transform = .identity
                self.labels[self.currentLabelIndex].textColor = .black
            }) { _ in
                self.currentLabelIndex += 1
                if self.currentLabelIndex < self.labels.count {
                    self.beginRefresh()
                } else {
                    self.scaleAnimation()
                }
            }
        }
    }
    
    func scaleAnimation() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveLinear, animations: {
            let scale = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labels.forEach {
                $0.transform = scale
            }
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: {
                self.labels.forEach {
                    $0.transform = .identity
                }
            }) { _ in
                if self.refreshControl.isRefreshing {
                    self.currentLabelIndex = 0
                    self.beginRefresh()
                } else {
                    self.isAnimating = false
                    self.currentLabelIndex = 0
                    self.labels.forEach {
                        $0.textColor = .black
                        $0.transform = .identity
                    }
                }
            }
        }
    }
}
