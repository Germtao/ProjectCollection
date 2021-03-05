//
//  TTFMSubCategoryModel.swift
//  TTXMLY
//
//  Created by QDSG on 2021/3/5.
//  Copyright © 2021 unitTao. All rights reserved.
//

import Foundation
import HandyJSON

struct TTFMSubCategoryModel: HandyJSON {
    var msg: String?
    var ret: Int = 0
    var gender: String?
    var keywords: [TTFMSubCategoryKeywords]?
    var categoryInfo: TTFMSubCategoryInfo?
}

struct TTFMSubCategoryKeywords: HandyJSON {
    var categoryId: Int = 0
    var keywordId: Int = 0
    var keywordName: String?
    var keywordType: Int = 0
    var realCategoryId: Int = 0
}

struct TTFMSubCategoryInfo: HandyJSON {
    var categoryType: Int = 0
    var contentType: String?
    var filterSupported: Bool = false
    var moduleType: Int = 0
    var name: String?
    var title: String?
}
