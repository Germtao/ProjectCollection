//
//  TTFMHomeLiveRankCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/11.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMHomeLiveRankCell: UICollectionViewCell {
    static let reuseIdentifier = "homeLiveRankCellID"
    
    var timer: Timer?
    
    private var rankList: [TTFMMultidimensionalRankVosModel]?
    
    func configure(with list: [TTFMMultidimensionalRankVosModel]?) {
        guard let list = list else { return }
        rankList = list
        collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        startTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: Constants.Sizes.screenW - 30, height: self.frame.height)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Constants.Colors.sectionFooter
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        view.register(TTFMLiveRankCell.self, forCellWithReuseIdentifier: TTFMLiveRankCell.reuseIdentifer)
        return view
    }()
}

extension TTFMHomeLiveRankCell {
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
    
    private func startTimer() {
        let timer = Timer(timeInterval: 3, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
    }
    
    @objc private func nextPage() {
        // 1.获取collectionView的X轴滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

extension TTFMHomeLiveRankCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (rankList?.count ?? 0) * 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMLiveRankCell.reuseIdentifer,
                                                      for: indexPath) as! TTFMLiveRankCell
        cell.configure(with: rankList?[indexPath.item % (rankList?.count)!])
        return cell
    }
}

extension TTFMHomeLiveRankCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item % (rankList?.count)!)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        startTimer()
    }
}
