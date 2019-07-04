//
//  TTHomeRecommendViewController.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/1.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import SnapKit

class TTHomeRecommendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.purple
        
        setupUI()
        loadData()
        loadRecommendAdData()
    }
    
    // MARK: - 懒加载
    lazy var viewModel = TTFMRecommendViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.white
        
        view.register(TTFMRecommendHeaderCell.self, forCellWithReuseIdentifier: TTFMRecommendHeaderCell.reuseIdentifier)
        view.register(TTFMRecommendAdCell.self, forCellWithReuseIdentifier: TTFMRecommendAdCell.reuseIdentifier)
        
        return view
    }()
}

// MARK: - 设置UI & 加载数据
extension TTHomeRecommendViewController {
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    private func loadData() {
        viewModel.updateDataHandler = { [unowned self] in
            self.collectionView.reloadData()
        }
        viewModel.refreshData()
    }
    
    private func loadRecommendAdData() {
        viewModel.updateDataHandler = { [unowned self] in
            self.collectionView.reloadData()
        }
        viewModel.refreshAdData()
    }
}

extension TTHomeRecommendViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendHeaderCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendHeaderCell
            cell.configure(with: viewModel.recommendFocusModel)
            cell.configure(with: viewModel.recommendSquareList)
            cell.configure(with: viewModel.recommendNewsList)
            return cell
        } else { // ad
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendAdCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendAdCell
            if indexPath.section == 7 {
                cell.configure(with: viewModel.recommendAdList?[0])
            } else if indexPath.section == 13 {
                cell.configure(with: viewModel.recommendAdList?[1])
            }
            return cell
        }
    }
    
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

extension TTHomeRecommendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetsForSections
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSections
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSections
    }
    
    
}
