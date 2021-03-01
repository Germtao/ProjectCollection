//
//  TTFMCategoryModel.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/8.
//  Copyright © 2019 unitTao. All rights reserved.
//

import HandyJSON

struct TTFMHomeCategoryModel: HandyJSON {
    var msg: String?
    var code: String?
    var ret: Int = 0
    var list: [TTFMCategoryModel]?
}

struct TTFMCategoryModel: HandyJSON {
    var groupName: String?
    var displayStyleType: Int = 0
    var itemList: [TTFMCategoryItemList]?
}

struct TTFMCategoryItemList: HandyJSON {
    var itemType: Int = 0
    var coverPath: String?
    var isDisplayCornerMark: Bool = false
    var itemDetail: TTFMCategoryItemDetail?
}

struct TTFMCategoryItemDetail: HandyJSON {
    var categoryId: Int = 0
    var categoryType: Int = 0
    var moduleType: Int = 0
    var keywordId: Int = 0
    
    var filterSupported: Bool = false
    
    var name: String?
    var title: String?
    var keywordName: String?
}
