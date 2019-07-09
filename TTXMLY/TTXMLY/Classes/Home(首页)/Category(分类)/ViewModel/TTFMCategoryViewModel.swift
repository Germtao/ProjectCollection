//
//  TTFMCategoryViewModel.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/8.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class TTFMCategoryViewModel: NSObject {
    var categoryModels: [TTFMCategoryModel]?
    
    /// 更新数据回调
    var updateDataHandler: (() -> Void)?
}

extension TTFMCategoryViewModel {
    /// 刷新数据
    func refreshData() {
        TTFMCategoryProvider.request(.categoryList) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<TTFMHomeCategoryModel>.deserializeFrom(json: json.description) {
                    self.categoryModels = mappedObject.list
                }
                
                self.updateDataHandler?()
            }
        }
    }
}

extension TTFMCategoryViewModel {
    var numberOfSections: Int {
        return categoryModels?.count ?? 0
    }
    
    func numberOfItems(in section: Int) -> Int {
        return categoryModels?[section].itemList?.count ?? 0
    }
    
    /// 每个分区的内边距
    var insetForSection: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
    }
    
    /// 最小item的间距
    var minimumInteritemSpacing: CGFloat {
        return 0.0
    }
    
    /// 最小行间距
    var minimumLineSpacing: CGFloat {
        return 2.0
    }
    
    func sizeForItem(at indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0, 1, 2:
            return CGSize(width: (Size.screenW - 10) / 4, height: 40)
        default:
            return CGSize(width: (Size.screenW - 7.5) / 3, height: 40)
        }
    }
    
    func sizeForHeader(in section: Int) -> CGSize {
        switch section {
        case 0, 1, 2:
            return .zero
        default:
            return CGSize(width: Size.screenH, height: 30)
        }
    }
    
    func sizeForFooter(in section: Int) -> CGSize {
        return CGSize(width: Size.screenW, height: 8)
    }
}
