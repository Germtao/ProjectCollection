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
        
        view.register(TTFMRecommendCarouselCell.self,
                      forCellWithReuseIdentifier: TTFMRecommendCarouselCell.reuseIdentifier)
        view.register(TTFMRecommendSquareCell.self,
                      forCellWithReuseIdentifier: TTFMRecommendSquareCell.reuseIdentifier)
        view.register(TTFMRecommendNewsCell.self,
                      forCellWithReuseIdentifier: TTFMRecommendNewsCell.reuseIdentifier)
        view.register(TTFMRecommendGuessULikeCell.self,
                      forCellWithReuseIdentifier: TTFMRecommendGuessULikeCell.reuseIdentifier)
        view.register(TTFMRecommendAudioBookCell.self,
                      forCellWithReuseIdentifier: TTFMRecommendAudioBookCell.reuseIdentifier)
        view.register(TTFMRecommendAdCell.self,
                      forCellWithReuseIdentifier: TTFMRecommendAdCell.reuseIdentifier)
        
        view.register(TTFMRecommendHeaderView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: TTFMRecommendHeaderView.reuseIdentifier)
        view.register(TTFMRecommendFooterView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: TTFMRecommendFooterView.reuseIdentifier)
        
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
            print(self.viewModel.numberOfSections)
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
        if moduleType == "focus" { // 轮播图
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendCarouselCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendCarouselCell
            cell.configure(with: viewModel.recommendFocusModel)
            return cell
        } else if moduleType == "square" { // 九宫格
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendSquareCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendSquareCell
            cell.configure(with: viewModel.recommendSquareList)
            return cell
        } else if moduleType == "topBuzz" { // 听头条
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendNewsCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendNewsCell
            cell.configure(with: viewModel.recommendNewsList)
            return cell
        } else if moduleType == "guessYouLike" ||
            moduleType == "paidCategory" ||
            moduleType == "categoriesForLong" ||
            moduleType == "cityCategory" { // 猜你喜欢、精品、
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendGuessULikeCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendGuessULikeCell
            cell.configure(with: viewModel.homeRecommendList?[indexPath.section].list)
            return cell
        } else if moduleType == "categoriesForShort" { // 评书
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendAudioBookCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendAudioBookCell
            cell.configure(with: viewModel.homeRecommendList?[indexPath.section].list)
            return cell
        }
        else { // ad
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: TTFMRecommendHeaderView.reuseIdentifier,
                                                                         for: indexPath) as! TTFMRecommendHeaderView
            header.configure(with: viewModel.homeRecommendList?[indexPath.section])
//            header.handler
            return header
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: TTFMRecommendFooterView.reuseIdentifier,
                                                                         for: indexPath) as! TTFMRecommendFooterView
            return footer
        }
        
        return UICollectionReusableView()
    }
}

extension TTHomeRecommendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.sizeForHeader(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.sizeForFooter(in: section)
    }
    
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
