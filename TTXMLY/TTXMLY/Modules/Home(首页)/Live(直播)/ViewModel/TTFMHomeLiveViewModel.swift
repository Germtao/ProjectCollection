//
//  TTFMHomeLiveViewModel.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

enum TTFMHomeLiveSectionType: Int {
    /// 分类
    case category
    /// 轮播
    case banner
    /// 排行
    case rank
    /// 直播
    case live
}

class TTFMHomeLiveViewModel: NSObject {
    /// 外部传值请求接口
    var categoryType: Int = 0
    
    convenience init(categoryType: Int = 0) {
        self.init()
        self.categoryType = categoryType
    }
    
    var homeLiveData: TTFMHomeLiveDataModel?
    var lives: [TTFMLivesModel]?
    var categoryVoList: [TTFMCategoryVoList]?
    var homeLiveBannerList: [TTFMHomeLiveBannerList]?
    var multidimensionalRankVos: [TTFMMultidimensionalRankVosModel]?
    
    var updateDataHandler: (() -> Void)?
}

extension TTFMHomeLiveViewModel {
    func refreshData() {
        loadLiveData()
    }
    
    private func loadLiveData() {
        let group = DispatchGroup()
        group.enter()
        // 首页直播数据请求
        TTFMHomeLiveApiProvider.request(.liveList) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<TTFMHomeLiveModel>.deserializeFrom(json: json.description) {
                    self.lives = mappedObject.data?.lives
                    self.categoryVoList = mappedObject.data?.categoryVoList
                    group.leave()
                }
            }
        }
        
        group.enter()
        // 首页直播轮播数据请求
        TTFMHomeLiveApiProvider.request(.liveBannerList) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<TTFMHomeLiveBannerModel>.deserializeFrom(json: json.description) {
                    self.homeLiveBannerList = mappedObject.data
                    group.leave()
                }
            }
        }
        
        group.enter()
        // 首页直播排行榜请求
        TTFMHomeLiveApiProvider.request(.liveRankList) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<TTFMHomeLiveRankModel>.deserializeFrom(json: json.description) {
                    self.multidimensionalRankVos = mappedObject.data?.multidimensionalRankVos
                    group.leave()
                }
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.updateDataHandler?()
        }
    }
}

extension TTFMHomeLiveViewModel {
    var numberOfSections: Int {
        return 4
    }
    
    func numberOfItems(in section: Int) -> Int {
        if section == TTFMHomeLiveSectionType.live.rawValue {
            return lives?.count ?? 0
        } else {
            return 1
        }
    }
    
    func sizeForItem(at indexPath: IndexPath) -> CGSize {
        let itemW = Size.screenW - 30
        switch indexPath.section {
        case TTFMHomeLiveSectionType.category.rawValue:
            return CGSize(width: itemW, height: 90)
        case TTFMHomeLiveSectionType.banner.rawValue:
            return CGSize(width: itemW, height: 110)
        case TTFMHomeLiveSectionType.rank.rawValue:
            return CGSize(width: itemW, height: 70)
        default:
            return CGSize(width: (Size.screenW - 40) / 2, height: 230)
        }
    }
    
    func sizeForHeader(in section: Int) -> CGSize {
        switch section {
        case TTFMHomeLiveSectionType.live.rawValue:
            return CGSize(width: Size.screenW, height: 40)
        default:
            return .zero
        }
    }
    
    func sizeForFooter(in section: Int) -> CGSize {
        switch section {
        case TTFMHomeLiveSectionType.banner.rawValue,
             TTFMHomeLiveSectionType.rank.rawValue:
            return CGSize(width: Size.screenW, height: 10)
        default:
            return .zero
        }
    }
}
