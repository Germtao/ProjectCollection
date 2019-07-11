//
//  TTHomeLiveViewController.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTHomeLiveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.white
        view.showsVerticalScrollIndicator = false
        view.register(TTFMHomeLiveBannerCell.self, forCellWithReuseIdentifier: TTFMHomeLiveBannerCell.reuseIdentifier)
        view.register(TTFMHomeLiveCategoryCell.self, forCellWithReuseIdentifier: TTFMHomeLiveCategoryCell.reuseIdentifier)
        view.register(TTFMHomeLiveRankCell.self, forCellWithReuseIdentifier: TTFMHomeLiveRankCell.reuseIdentifier)
        view.register(TTFMHomeLiveRecommendCell.self, forCellWithReuseIdentifier: TTFMHomeLiveRecommendCell.reuseIdentifier)
        view.register(TTFMHomeLiveHeaderView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: TTFMHomeLiveHeaderView.reuseIdentifer)
        view.register(TTFMHomeLiveFooterView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: TTFMHomeLiveFooterView.reuseIdentifier)
        return view
    }()
    
    private lazy var viewModel = TTFMHomeLiveViewModel()
}

extension TTHomeLiveViewController {
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.bottom.equalToSuperview()
        }
    }
    
    private func loadData() {
        viewModel.updateDataHandler = { [unowned self] in
            self.collectionView.reloadData()
        }
        viewModel.refreshData()
    }
}

extension TTHomeLiveViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case TTFMHomeLiveSectionType.banner.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMHomeLiveBannerCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMHomeLiveBannerCell
            cell.configure(with: viewModel.homeLiveBannerList)
            return cell
        case TTFMHomeLiveSectionType.category.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMHomeLiveCategoryCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMHomeLiveCategoryCell
            return cell
        case TTFMHomeLiveSectionType.rank.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMHomeLiveRankCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMHomeLiveRankCell
            cell.configure(with: viewModel.multidimensionalRankVos)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMHomeLiveRecommendCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMHomeLiveRecommendCell
            cell.configure(with: viewModel.lives?[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: TTFMHomeLiveHeaderView.reuseIdentifer,
                                                                         for: indexPath) as! TTFMHomeLiveHeaderView
            return header
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: TTFMHomeLiveFooterView.reuseIdentifier,
                                                                         for: indexPath) as! TTFMHomeLiveFooterView
            return footer
        }
        return UICollectionReusableView()
    }
}

extension TTHomeLiveViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.sizeForHeader(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.sizeForFooter(in: section)
    }
}
