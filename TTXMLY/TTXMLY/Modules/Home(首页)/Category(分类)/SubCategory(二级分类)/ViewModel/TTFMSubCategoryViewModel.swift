//
//  TTFMSubCategoryViewModel.swift
//  TTXMLY
//
//  Created by QDSG on 2021/3/5.
//  Copyright © 2021 unitTao. All rights reserved.
//

import Foundation

class TTFMSubCategoryViewModel: NSObject {
    var categoryId: Int = 0
    
    convenience init(categoryId: Int = 0) {
        self.init()
        self.categoryId = categoryId
    }
    
    var updateDataClosure: (() -> Void)?
}

extension TTFMSubCategoryViewModel {
    func requestHeaderCategoryKeywords() {
        TTFMNetworkManager.shared.request(target: TTFMSubCategoryApi.headerCategoryList(categoryId: categoryId)) { (json, message, code) in
            print("二级分类 header json = \(json)")
        }
    }
    
    func refreshDataSource() {
        TTFMNetworkManager.shared.request(target: TTFMSubCategoryApi.categoryRecommendList(categoryId: categoryId)) { (json, message, code) in
            print("二级分类 json: \(json)")
        }
    }
}


