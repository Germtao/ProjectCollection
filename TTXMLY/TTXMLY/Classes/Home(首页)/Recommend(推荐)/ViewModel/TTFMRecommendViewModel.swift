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

class TTFMRecommendViewModel: NSObject {
    
    var homeRecommendModel: TTHomeRecommendModel?
    var homeRecommendList: [TTFMRecommendModel]?
    var recommendList: [TTFMRecommendListModel]?
    /// 轮播图数据
    var recommendFocusModel: TTFMRecommendFocusModel?
    /// 九宫格数据
    var recommendSquareList: [TTFMRecommendSquareModel]?
    /// 听头条数据
    var recommendNewsList: [TTFMRecommendNewsModel]?
    
    var recommendAdList: [TTFMRecommendAdModel]?
    
    /// 更新数据回调
    var updateDataHandler: (() -> Void)?
}

extension TTFMRecommendViewModel {
    /// 刷新推荐页面数据
    func refreshData() {
        TTFMRecommendProvider.request(.recommendList) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<TTHomeRecommendModel>.deserializeFrom(json: json.description) {
                    self.homeRecommendModel = mappedObject
                    self.homeRecommendList = mappedObject.list
                    if let recommendList = JSONDeserializer<TTFMRecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                        self.recommendList = recommendList as? [TTFMRecommendListModel]
                    }
                    
                    if let recommendFocus = JSONDeserializer<TTFMRecommendFocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description) {
                        self.recommendFocusModel = recommendFocus
                    }
                    
                    if let recommendSquareList = JSONDeserializer<TTFMRecommendSquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description) {
                        self.recommendSquareList = recommendSquareList as? [TTFMRecommendSquareModel]
                    }
                    
                    if let recommendNewsList = JSONDeserializer<TTFMRecommendNewsModel>.deserializeModelArrayFrom(json: json["list"][2]["list"].description) {
                        self.recommendNewsList = recommendNewsList as? [TTFMRecommendNewsModel]
                    }
                    
                    // 更新数据回调
                    self.updateDataHandler?()
                }
            }
        }
    }
    
    /// 刷新推荐页面ad数据
    func refreshAdData() {
        TTFMRecommendProvider.request(.recommendListWithAd) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let adList = JSONDeserializer<TTFMRecommendAdModel>.deserializeModelArrayFrom(json: json["data"].description) {
                    self.recommendAdList = adList as? [TTFMRecommendAdModel]
                    
                    // 广告数据更新
                    self.updateDataHandler?()
                }
            }
        }
    }
}

// MARK: - collectionView 设置属性
extension TTFMRecommendViewModel {
    /// section数量
    var numberOfSections: Int {
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
        let moduleType = homeRecommendList?[indexPath.section].moduleType
        if moduleType == "focus" {
            return CGSize(width: Size.screenW, height: 360)
        } else if moduleType == "square" ||
            moduleType == "topBuzz" {
            return CGSize.zero
        } else if moduleType == "guessYouLike" ||
            moduleType == "paidCategory" ||
            moduleType == "categoriesForLong" ||
            moduleType == "cityCategory" ||
            moduleType == "live" {
            return CGSize(width: Size.screenW, height: headerAndFooterHeight + CGFloat(180 * itemNums))
        } else if moduleType == "categoriesForShort" ||
            moduleType == "playlist" ||
            moduleType == "categoriesForExplore" {
            return CGSize(width: Size.screenW, height: headerAndFooterHeight + CGFloat(120 * count))
        } else if moduleType == "ad" {
            return CGSize(width: Size.screenW, height: 240)
        } else if moduleType == "oneKeyListen" {
            return CGSize(width: Size.screenW, height: 180)
        } else {
            return .zero
        }
    }
    
    /// 分区header尺寸
    func sizeForHeader(in section: Int) -> CGSize {
        let moduleType = homeRecommendList?[section].moduleType
        if moduleType == "focus" ||
            moduleType == "square" ||
            moduleType == "topBuzz" ||
            moduleType == "ad" ||
            section == 18 {
            return .zero
        }
        
        return CGSize(width: Size.screenW, height: 40.0)
    }
    
    /// 分区footer尺寸
    func sizeForFooter(in section: Int) -> CGSize {
        let moduleType = homeRecommendList?[section].moduleType
        if moduleType == "focus" ||
            moduleType == "square" {
            return .zero
        }
        
        return CGSize(width: Size.screenW, height: 10.0)
    }
}
