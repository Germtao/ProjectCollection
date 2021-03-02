//
//  TTHomeCategoryViewController.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/8.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTHomeCategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }
    
    // MARK: - 懒加载
    private lazy var viewModel = TTFMCategoryViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = Constants.Colors.sectionFooter
        view.register(TTFMCategoryCell.self, forCellWithReuseIdentifier: TTFMCategoryCell.reuseIdentifier)
        view.register(TTFMCategoryHeaderView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: TTFMCategoryHeaderView.reuseIdentifier)
        view.register(TTFMCategoryFooterView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: TTFMCategoryFooterView.reuseIdentifier)
        return view
    }()
}

extension TTHomeCategoryViewController {
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadData() {
        viewModel.updateDataHandler = { [unowned self] in
            self.collectionView.reloadData()
        }
        viewModel.refreshData()
    }
}

extension TTHomeCategoryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMCategoryCell.reuseIdentifier,
                                                      for: indexPath) as! TTFMCategoryCell
        cell.indexPath = indexPath
        cell.configure(with: viewModel.categoryModels?[indexPath.section].itemList?[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: TTFMCategoryHeaderView.reuseIdentifier,
                                                                         for: indexPath) as! TTFMCategoryHeaderView
            header.configure(with: viewModel.categoryModels?[indexPath.section].groupName)
            return header
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: TTFMCategoryFooterView.reuseIdentifier,
                                                                         for: indexPath) as! TTFMCategoryFooterView
            return footer
        }
        return UICollectionReusableView()
    }
}

extension TTHomeCategoryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacing
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
