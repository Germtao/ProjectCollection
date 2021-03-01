//
//  TTFMHomeVipViewModel.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/9.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

enum TTFMVipCellSecionType: Int {
    /// 轮播图
    case banner
    /// 分类
    case categoty
    /// 热
    case hot
    /// 尊享
    case enjoy
    /// vip
    case vip
}

class TTFMHomeVipViewModel: NSObject {
    var homeVipModel: TTFMHomeVipModel?
    var focusImages: [TTFMFocusImagesData]?
    var categoryList: [TTFMCategoryList]?
    var categoryBtnList: [TTFMCategoryButtonModel]?
    
    /// 更新回调
    var updateDataHandler: (() -> Void)?
}

extension TTFMHomeVipViewModel {
    /// 刷新数据
    func refreshData() {
        TTFMHomeVipProvider.request(.vipList) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<TTFMHomeVipModel>.deserializeFrom(json: json.description) {
                    self.homeVipModel = mappedObject
                    self.focusImages = mappedObject.focusImages?.data
                    self.categoryList = mappedObject.categoryContents?.list
                }
                
                if let categoryBtnList = JSONDeserializer<TTFMCategoryButtonModel>.deserializeModelArrayFrom(json: json["categoryContents"]["list"][0]["list"].description) {
                    self.categoryBtnList = categoryBtnList as? [TTFMCategoryButtonModel]
                }
                
                self.updateDataHandler?()
            }
        }
    }
}

extension TTFMHomeVipViewModel {
    var numberOfSections: Int {
        return categoryList?.count ?? 0
    }
    
    func numberOfRows(in section: Int) -> Int {
        switch section {
        case TTFMVipCellSecionType.vip.rawValue:
            return categoryList?[section].list?.count ?? 0
        default:
            return 1
        }
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case TTFMVipCellSecionType.banner.rawValue:
            return 150.0
        case TTFMVipCellSecionType.categoty.rawValue:
            return 80.0
        case TTFMVipCellSecionType.hot.rawValue:
            return 190.0
        case TTFMVipCellSecionType.enjoy.rawValue:
            return 230.0
        case TTFMVipCellSecionType.vip.rawValue:
            return 120.0
        default: return 0.0
        }
    }
    
    func heightForHeader(in section: Int) -> CGFloat {
        switch section {
        case TTFMVipCellSecionType.banner.rawValue,
             TTFMVipCellSecionType.categoty.rawValue:
            return 0.0
        default:
            return 50.0
        }
    }
    
    func heightForFooter(in section: Int) -> CGFloat {
        switch section {
        case TTFMVipCellSecionType.banner.rawValue:
            return 0.0
        default:
            return 10.0
        }
    }
}
