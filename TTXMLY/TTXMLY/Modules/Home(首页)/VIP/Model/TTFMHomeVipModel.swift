//
//  TTFMHomeVipModel.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/9.
//  Copyright © 2019 unitTao. All rights reserved.
//

import HandyJSON

struct TTFMHomeVipModel: HandyJSON {
    var msg: String?
    var ret: Int = 0
    var serverMilliseconds: Int = 0
    var focusImages: TTFMFocusImagesModel?
    var categoryContents: TTFMCategoryContentsModel?
}

struct TTFMFocusImagesModel: HandyJSON {
    var ret: Int = 0
    var responseId: Int = 0
    var data: [TTFMFocusImagesData]?
}

/// 轮播图
struct TTFMFocusImagesData: HandyJSON {
    var adId: Int = 0
    var adType: Int = 0
    var clickAction: Int = 0
    var clickType: Int = 0
    var displayType: Int = 0
    var isInternal: Int = 0
    var openlinkType: Int = 0
    var targetId: Int = 0
    
    var clickTokens: [Any]?
    var showTokens: [Any]?
    var thirdClickStatUrls: [Any]?
    var thirdShowStatUrls: [Any]?
    
    var buttonShowed: Bool = false
    var isAd: Bool = false
    var isLandScape: Bool = false
    var isShareFlag: Bool = false
    
    var cover: String?
    var description: String?
    var link: String?
    var name: String?
    var realLink: String?
}

struct TTFMCategoryContentsModel: HandyJSON {
    var title: String?
    var list: [TTFMCategoryList]?
}

struct TTFMCategoryList: HandyJSON {
    var calcDimension: String?
    var cardClass: String?
    var contentType: String?
    var keywordName: String?
    var tagName: String?
    var title: String?
    
    var hasMore: Bool = false
    
    var keywordId: Int = 0
    var moduleType: Int = 0
    
    var list: [TTFMCategoryContents]?
}

struct TTFMCategoryContents: HandyJSON {
    var albumCoverUrl290: String?
    var coverLarge: String?
    var coverMiddle: String?
    var coverSmall: String?
    var displayDiscountedPrice: String?
    var displayPrice: String?
    var intro: String?
    var nickname: String?
    var priceUnit: String?
    var provider: String?
    var tags: String?
    var title: String?
    var trackTitle: String?
    
    var isDraft: Bool = false
    var isPaid: Bool = false
    var isVipFree: Bool = false
    
    var albumId: Int = 0
    var commentsCount: Int = 0
    var discountedPrice: CGFloat = 0.0
    var id: Int = 0
    var isFinished: Int = 0
    var playsCounts: Int = 0
    var price: CGFloat = 0.0
    var priceTypeEnum: Int = 0
    var priceTypeId: Int = 0
    var refundSupportType: Int = 0
    var score: CGFloat = 0.0
    var serialState: Int = 0
    var trackId: Int = 0
    var tracks: Int = 0
    var uid: Int = 0
    var vipFreeType: Int = 0
}

// MARK: - 滚动按钮
struct TTFMCategoryButtonModel: HandyJSON {
    var bubbleText: String?
    var contentType: String?
    var contentUpdatedAt: Int = 0
    var coverPath: String?
    var displayClass: String?
    var enableShare: Bool = false
    var id: Int = 0
    var isExternalUrl: Bool = false
    var sharePic: String?
    var subtitle: String?
    var title: String?
    var url: String?
    var properties: TTFMCategoryPropertiesModel?
}

struct TTFMCategoryPropertiesModel: HandyJSON {
    var isPaid: Bool = false
    var type: String?
    var uri: String?
}
