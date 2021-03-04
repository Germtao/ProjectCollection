//
//  TTFMRecommendNewsCell.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/3.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

private let newsCellWidth: CGFloat = Constants.Sizes.screenW - 150.0
private let newsCellHeight: CGFloat = 40.0
private let newsCellSection = 100

class TTFMRecommendNewsCell: UICollectionViewCell {
    
    static let reuseIdentifier = "recommendNewsCellID"
    
    var timer: Timer?
    
    private var newsList: [TTFMRecommendListModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    func configure(with news: [TTFMRecommendListModel]?) {
        guard let news = news else { return }
        newsList = news
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        
        startTimer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
        
        startTimer()
    }
    
    // MARK: - 懒加载
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: newsCellWidth, height: newsCellHeight)
        
        let view = UICollectionView(frame: CGRect(x: 80, y: 5, width: newsCellWidth, height: newsCellHeight),
                                    collectionViewLayout: layout)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true
        view.register(TTFMNewsCell.self, forCellWithReuseIdentifier: TTFMNewsCell.reuseIdentifier)
        return view
    }()
    
    private lazy var moreBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("|  更多", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = Constants.Fonts.font(15.0)
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "news")
        return view
    }()
}

extension TTFMRecommendNewsCell {
    private func makeUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(moreBtn)
        contentView.addSubview(collectionView)
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 60.0, height: 30.0))
            make.top.equalTo(10)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.equalTo(moreBtn.snp.left).offset(-10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5.0)
            make.size.equalTo(CGSize(width: 60.0, height: 40.0))
            make.top.equalTo(5)
        }
    }
    
    private func startTimer() {
        let timer = Timer(timeInterval: 2.0, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        // 这一句代码涉及到runloop 和 主线程的知识,则在界面上不能执行其他的UI操作
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
    }
    
    private func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func nextPage() {
        // 1. 获取collectionView的y轴滚动的偏移量
        var offsetY = collectionView.contentOffset.y + collectionView.bounds.height
        
        if offsetY >= collectionView.contentSize.height * CGFloat(newsList?.count ?? 0) {
            offsetY = 0
        }
        
        // 2. 滚动至该位置
        collectionView.setContentOffset(CGPoint(x: 0.0, y: offsetY), animated: true)
    }
}

extension TTFMRecommendNewsCell: UICollectionViewDataSource, UICollectionViewDelegate {
    /// 当collectionView开始拖拽时, 取消timer
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    /// 当collectionView将结束拖拽时, 开启timer
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        startTimer()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return newsCellSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMNewsCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMNewsCell
        cell.configure(with: newsList?[indexPath.item % (newsList?.count)!])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("TTFMRecommendNewsCell - didSelect: %d", indexPath.item)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: newsCellWidth, height: newsCellHeight)
//    }
}

class TTFMNewsCell: UICollectionViewCell {
    
    static let reuseIdentifier = "newsCellID"
    
    func configure(with model: TTFMRecommendListModel?) {
        titleLabel.text = model?.title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    private func makeUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(2)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.font(16.0)
        label.textAlignment = .center
        return label
    }()
}
