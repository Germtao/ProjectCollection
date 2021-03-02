//
//  TTFMHomeBroadcastViewModel.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/11.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

enum TTFMHomeBroadcastSectionType: Int {
    /// 电台
    case radio
    /// 可展开电台
    case expandableRadio
    /// 本地section
    case local
    /// 排行榜
    case rank
}

class TTFMHomeBroadcastViewModel: NSObject {
    // MARK: - 数据模型
    var categories: [TTFMRadiosCategoriesModel]?
    var localRadios: [TTFMRadiosModel]?
    var radioSquareResults: [TTFMRadiosSquareResultsModel]?
    var topRadios: [TTFMRadiosModel]?
    
    // 以下3个model - 控制展开/收起时电台数据显示
    let bottomModel = TTFMRadiosCategoriesModel(id: 10000, name: "arrow_bottom.png")
    let topModel = TTFMRadiosCategoriesModel(id: 10000, name: "arrow_top.png")
    let coverModel = TTFMRadiosCategoriesModel(id: 10000, name: " ")
    
    var updateDataHandler: (() -> Void)?
    
    /// 是否可展开, 默认 false
    var isExpand: Bool = false
    
    var titleArr = ["上海", "排行榜"]
}

extension TTFMHomeBroadcastViewModel {
    func refreshData() {
        TTFMHomeBroadcastProvider.request(.broadcastList) { (result) in
            if case let .success(response) = result {
                do {
                    let data = try response.mapJSON()
                    let json = JSON(data)
                    if let mappedObject = JSONDeserializer<TTFMHomeBroadcastModel>.deserializeFrom(json: json.description) {
                        self.categories = mappedObject.data?.categories
                        self.localRadios = mappedObject.data?.localRaios
                        self.radioSquareResults = mappedObject.data?.radioSquareResults
                        self.topRadios = mappedObject.data?.topRadios
                        
                        self.categories?.insert(self.bottomModel, at: 7)
                        self.categories?.append(self.topModel)
                        
                        self.updateDataHandler?()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension TTFMHomeBroadcastViewModel {
    
    var numberOfSections: Int {
        return 4
    }
    
    func numberOfItems(in section: Int) -> Int {
        switch section {
        case TTFMHomeBroadcastSectionType.radio.rawValue:
            return 1
        case TTFMHomeBroadcastSectionType.expandableRadio.rawValue:
            if isExpand {
                return categories?.count ?? 0
            } else {
                return (categories?.count ?? 0) / 2
            }
        case TTFMHomeBroadcastSectionType.local.rawValue:
            return localRadios?.count ?? 0
        case TTFMHomeBroadcastSectionType.rank.rawValue:
            return topRadios?.count ?? 0
        default: return 0
        }
    }
    
    func insetForSection(at section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    /// 最小 item 间距
    func minimumInteritemSpacingForSection(at section: Int) -> CGFloat {
        switch section {
        case TTFMHomeBroadcastSectionType.expandableRadio.rawValue:
            return 1
        default:
            return 0.0
        }
    }
    
    /// 最小行间距
    func minimumLineSpacingForSection(at section: Int) -> CGFloat {
        switch section {
        case TTFMHomeBroadcastSectionType.expandableRadio.rawValue:
            return 1
        default:
            return 0.0
        }
    }
    
    func sizeForItem(at indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case TTFMHomeBroadcastSectionType.radio.rawValue:
            return CGSize(width: Constants.Sizes.screenW, height: 90)
        case TTFMHomeBroadcastSectionType.expandableRadio.rawValue:
            return CGSize(width: (Constants.Sizes.screenW - 5) / 4, height: 45)
        default:
            return CGSize(width: Constants.Sizes.screenW, height: 120)
        }
    }
    
    func sizeForHeader(in section: Int) -> CGSize {
        switch section {
        case TTFMHomeBroadcastSectionType.radio.rawValue,
             TTFMHomeBroadcastSectionType.expandableRadio.rawValue:
            return .zero
        default:
            return CGSize(width: Constants.Sizes.screenW, height: 40)
        }
    }
    
    func sizeForFooter(in section: Int) -> CGSize {
        switch section {
        case TTFMHomeBroadcastSectionType.radio.rawValue,
             TTFMHomeBroadcastSectionType.expandableRadio.rawValue:
            return .zero
        default:
            return CGSize(width: Constants.Sizes.screenW, height: 10)
        }
    }
}
