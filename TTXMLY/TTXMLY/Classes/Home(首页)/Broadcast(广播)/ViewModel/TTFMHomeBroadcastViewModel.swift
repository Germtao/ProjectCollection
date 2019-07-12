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
    func numberOfItems(in section: Int) -> Int {
        switch section {
        case TTFMHomeBroadcastSectionType.radio.rawValue:
            return 
        default:
            <#code#>
        }
    }
}
