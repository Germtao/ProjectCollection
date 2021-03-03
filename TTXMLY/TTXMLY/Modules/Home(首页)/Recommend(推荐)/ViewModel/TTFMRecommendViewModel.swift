//
//  TTFMRecommendViewModel.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/2.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Foundation
import HandyJSON
import SwiftyJSON

class TTFMRecommendViewModel {
    
    var homeRecommendList: [TTFMRecommendModel]?
    /// 九宫格数据
    var recommendSquareList: [TTFMRecommendSquareModel]?
    
    var recommendAdList: [TTFMRecommendAdModel]?
    
    /// 懒人电台
    var oneKeyListenList: [TTFMOneKeyListenModel]?
    
    /// 更新数据回调
    var updateDataHandler: ((RequestErrorCode, String?) -> Void)?
}

extension TTFMRecommendViewModel {
    /// 刷新推荐页面数据
    func refreshData() {
        TTFMRecommendProvider.request(.recommendList) { (result) in
            switch result {
            case .success(let response):
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                print("推荐页面数据 json: \(json)")
                
                if let homeRecommendList = JSONDeserializer<TTFMRecommendModel>.deserializeModelArrayFrom(json: json["list"].description) as? [TTFMRecommendModel] {
                    self.homeRecommendList = homeRecommendList
                    
                    if let recommendSquareList = JSONDeserializer<TTFMRecommendSquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description) {
                        self.recommendSquareList = recommendSquareList as? [TTFMRecommendSquareModel]
                    }
                    
                    if let oneKeyListen = JSONDeserializer<TTFMOneKeyListenModel>.deserializeModelArrayFrom(json: json["list"][9]["list"].description) {
                        self.oneKeyListenList = oneKeyListen as? [TTFMOneKeyListenModel]
                    }
                    
                    // 更新数据回调
                    self.updateDataHandler?(.success, nil)
                } else {
                    self.updateDataHandler?(.failure, Constants.Strings.resolveDataError)
                }
            case .failure(let error):
                self.updateDataHandler?(.failure, error.errorDescription)
        }
        }
    }
    
    /// 刷新推荐页面ad数据
    func refreshAdData() {
        TTFMRecommendProvider.request(.recommendListWithAd) { (result) in
            switch result {
            case .success(let response):
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let adList = JSONDeserializer<TTFMRecommendAdModel>.deserializeModelArrayFrom(json: json["data"].description) {
                    self.recommendAdList = adList as? [TTFMRecommendAdModel]
                    
                    // 广告数据更新
                    self.updateDataHandler?(.success, nil)
                } else {
                    self.updateDataHandler?(.failure, Constants.Strings.resolveDataError)
                }
            case .failure(let error):
                self.updateDataHandler?(.failure, error.errorDescription)
            }
        }
    }
}

// MARK: - collectionView 设置属性
extension TTFMRecommendViewModel {
    /// section数量
    var numberOfSections: Int {
        print(homeRecommendList?.count ?? 0)
        return homeRecommendList?.count ?? 0
    }
    
    var numberOfItems: Int {
        return 1
    }
    
    /// 每个section的内边距
    var insetsForSections: UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    var minimumInteritemSpacingForSections: CGFloat {
        return 0
    }
    
    var minimumLineSpacingForSections: CGFloat {
        return 0
    }
    
    /// item尺寸
    func sizeForItem(at indexPath: IndexPath) -> CGSize {
        let headerAndFooterHeight: CGFloat = 90.0
        let count = homeRecommendList?[indexPath.section].list?.count ?? 0
        let itemNums = count / 3
        let moduleType = homeRecommendList?[indexPath.section].moduleType ?? .unknown
        
        switch moduleType {
        case .focus:
            return CGSize(width: Constants.Sizes.screenW, height: 150)
        case .square:
            return recommendSquareList?.count == 0
                ? .zero
                : CGSize(width: Constants.Sizes.screenW, height: 160)
        case .topBuzz:
            return homeRecommendList?[indexPath.section].list?.count == 0
                ? .zero
                : CGSize(width: Constants.Sizes.screenW, height: 50)
        case .guessYouLike,
             .paidCategory,
             .categoriesForLong,
             .cityCategory,
             .live:
            return CGSize(width: Constants.Sizes.screenW, height: headerAndFooterHeight + CGFloat(180 * itemNums))
        case .categoriesForShort,
             .playlist,
             .categoriesForExplore,
             .microLesson:
            return homeRecommendList?[indexPath.section].list?.count == 0
                ? .zero
                : CGSize(width: Constants.Sizes.screenW, height: headerAndFooterHeight + CGFloat(120 * count))
        case .ad:
            return homeRecommendList?[indexPath.section].list?.count == 0
                ? .zero
                : CGSize(width: Constants.Sizes.screenW, height: 240)
        case .oneKeyListen:
            return CGSize(width: Constants.Sizes.screenW, height: 180)
        default:
            return .zero
        }
    }
    
    /// 分区header尺寸
    func sizeForHeader(in section: Int) -> CGSize {
        let moduleType = homeRecommendList?[section].moduleType
        if moduleType == .focus ||
            moduleType == .square ||
            moduleType == .topBuzz ||
            moduleType == .ad ||
            section == 18 {
            return .zero
        }
        
        return CGSize(width: Constants.Sizes.screenW, height: 40.0)
    }
    
    /// 分区footer尺寸
    func sizeForFooter(in section: Int) -> CGSize {
        let moduleType = homeRecommendList?[section].moduleType
        if moduleType == .focus ||
            moduleType == .square {
            return .zero
        }
        
        return CGSize(width: Constants.Sizes.screenW, height: 10.0)
    }
}
