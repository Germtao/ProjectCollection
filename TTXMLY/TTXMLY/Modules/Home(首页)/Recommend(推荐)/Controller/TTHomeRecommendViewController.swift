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
        
        makeUI()
        loadData()
    }
    
    // MARK: - 懒加载
    private var viewModel = TTFMRecommendViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        
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
        view.register(TTFMReCommendOneKeyListenCell.self,
                      forCellWithReuseIdentifier: TTFMReCommendOneKeyListenCell.reuseIdentifier)
        view.register(TTFMRecommendLiveCell.self,
                      forCellWithReuseIdentifier: TTFMRecommendLiveCell.reuseIdentifier)
        view.register(TTFMRecommendForUCell.self,
                      forCellWithReuseIdentifier: TTFMRecommendForUCell.reuseIdentifier)
        
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
    private func makeUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.center.size.equalToSuperview()
        }
    }
    
    private func loadData() {
        viewModel.updateDataHandler = { [unowned self] (code, message) in
            switch code {
            case .failure:
                print("loadData error: \(message ?? "######")")
            case .success:
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        viewModel.refreshData()
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
        print("cellForItemAt - \(indexPath.section)")
        let moduleType = viewModel.homeRecommendList[indexPath.section].moduleType
        print("moduleType = \(moduleType.rawValue)")
        
        switch moduleType {
        case .focus: // 轮播图
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendCarouselCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendCarouselCell
            cell.configure(with: viewModel.homeRecommendList[indexPath.section].list?.first)
            return cell
        case .square: // 九宫格
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendSquareCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendSquareCell
            cell.configure(with: viewModel.recommendSquareList)
            return cell
        case .topBuzz: // 听头条
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendNewsCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendNewsCell
            cell.configure(with: viewModel.homeRecommendList[indexPath.section].list)
            return cell
        case .guessYouLike,
             .paidCategory,
             .categoriesForLong,
             .cityCategory,
             .microLesson: // 猜你喜欢、精品、亲子时光、音乐好时光、人文
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendGuessULikeCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendGuessULikeCell
            cell.delegate = self
            cell.configure(with: viewModel.homeRecommendList[indexPath.section])
            return cell
        case .categoriesForShort,
             .playlist,
             .categoriesForExplore: // 最热有声书、相声评书、精品听单
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendAudioBookCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendAudioBookCell
            cell.delegate = self
            cell.configure(with: viewModel.homeRecommendList[indexPath.section])
            return cell
        case .ad: // ad
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendAdCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendAdCell
            if indexPath.section == 7 {
                cell.configure(with: viewModel.recommendAdList?[0])
            } else if indexPath.section == 13 {
                cell.configure(with: viewModel.recommendAdList?[1])
            }
            return cell
        case .oneKeyListen: // 懒人电台
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMReCommendOneKeyListenCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMReCommendOneKeyListenCell
            cell.configure(with: viewModel.oneKeyListenList)
            return cell
        case .live: // 直播
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendLiveCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendLiveCell
            cell.configure(with: viewModel.homeRecommendList[indexPath.section].list)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTFMRecommendForUCell.reuseIdentifier,
                                                          for: indexPath) as! TTFMRecommendForUCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: TTFMRecommendHeaderView.reuseIdentifier,
                                                                         for: indexPath) as! TTFMRecommendHeaderView
            header.configure(with: viewModel.homeRecommendList[indexPath.section])
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
        print(viewModel.sizeForItem(at: indexPath))
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

extension TTHomeRecommendViewController: TTFMRecommendViewCellDelegate {
    func changeButtonClicked(_ cell: UICollectionViewCell, model: TTFMRecommendModel) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        viewModel.changeABatch(model) { (models, message, code) in
            switch code {
            case .failure:
                print("error: \(message?.debugDescription ?? "Unknown Error.")")
            case .success:
                if let models = models {
                    self.viewModel.homeRecommendList[indexPath.section].list = models
                    self.collectionView.reloadItems(at: [indexPath])
                }
            }
        }
    }
    
    func recommendGuessULikeCellClicked(model: TTFMRecommendListModel) {
        print("猜你喜欢 cell 点击")
    }
}
