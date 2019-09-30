//
//  ViewController.swift
//  PlayLocalVideo
//
//  Created by QDSG on 2019/9/30.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UITableViewController {
    
    var dataSource = [Video]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var player = AVPlayer()
    private var playerVc = AVPlayerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = [
            Video(image: UIImage(named: "videoCover01"),
                  title: "Introduce 3DS Mario",
                  source: "Youtube - 06:32"),
            Video(image: UIImage(named: "videoCover02"),
                  title: "Emoji Among Us",
                  source: "Vimeo - 3:34"),
            Video(image: UIImage(named: "videoCover03"),
                  title: "Seals Documentary",
                  source: "Vine - 00:06"),
            Video(image: UIImage(named: "videoCover04"),
                  title: "Adventure Time",
                  source: "Youtube - 02:39"),
            Video(image: UIImage(named: "videoCover05"),
                  title: "Facebook HQ",
                  source: "Facebook - 10:20"),
            Video(image: UIImage(named: "videoCover06"),
                  title: "Lijiang Lugu Lake",
                  source: "Allen - 20:30")
        ]
    }
}

extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoViewCell.reuseIdentifier,
                                                 for: indexPath) as! VideoViewCell
        cell.delegate = self
        let video = dataSource[indexPath.row]
        cell.configure(with: video)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

extension ViewController: VideoViewCellDelegate {
    func playVideo(cell: VideoViewCell) {
        let path = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")!
        player = AVPlayer(url: URL(fileURLWithPath: path))
        playerVc.player = player
        present(playerVc, animated: true) { [weak self] in
            self?.playerVc.player?.play()
        }
    }
}

