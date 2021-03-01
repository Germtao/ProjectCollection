//
//  TTHomeBroadcastViewController.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/11.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTHomeBroadcastViewController: UIViewController {
    
    private lazy var viewModel = TTFMHomeBroadcastViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        
        view.register(TTFMHomeBroadcastHeaderView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: TTFMHomeBroadcastHeaderView.reuseIdentifier)
        view.register(TTFMHomeBroadcastFooterView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: TTFMHomeBroadcastFooterView.reuseIdentifier)
        
        view.register(TTFMRadioSquareResultsCell.self,
                      forCellWithReuseIdentifier: TTFMRadioSquareResultsCell.reuseIdentifier)
        view.register(TTFMBroadcastRadioCell.self,
                      forCellWithReuseIdentifier: TTFMBroadcastRadioCell.reuseIdentifier)
        
        return view
    }()
}

extension TTHomeBroadcastViewController {
    private func setupUI() {
        view.backgroundColor = .white
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

extension TTHomeBroadcastViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case TTFMHomeBroadcastSectionType.radio.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRadioSquareResultsCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRadioSquareResultsCell
            cell.configure(with: viewModel.radioSquareResults)
            return cell
        case TTFMHomeBroadcastSectionType.expandableRadio.rawValue:
            let reuseIdentifier = "\(indexPath.section)\(indexPath.item)"
            collectionView.register(TTFMRadioExpandableCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                          for: indexPath) as! TTFMRadioExpandableCell
            cell.configure(with: viewModel.categories?[indexPath.item].name)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMBroadcastRadioCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMBroadcastRadioCell
            if indexPath.section == TTFMHomeBroadcastSectionType.local.rawValue {
                cell.configure(with: viewModel.localRadios?[indexPath.item])
            } else {
                cell.configure(with: viewModel.topRadios?[indexPath.item])
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: TTFMHomeBroadcastHeaderView.reuseIdentifier,
                                                                         for: indexPath) as! TTFMHomeBroadcastHeaderView
            header.configure(with: viewModel.titleArr[indexPath.section - 2])
            return header
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: TTFMHomeBroadcastFooterView.reuseIdentifier,
                                                                         for: indexPath) as! TTFMHomeBroadcastFooterView
            return footer
        }
        return UICollectionReusableView()
    }
}

extension TTHomeBroadcastViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.sizeForHeader(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.sizeForFooter(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSection(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSection(at: section)
    }
}
