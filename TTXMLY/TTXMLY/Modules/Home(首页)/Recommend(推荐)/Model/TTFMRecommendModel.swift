//
//  TTFMRecommendModel.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/2.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Foundation
import HandyJSON

struct TTHomeRecommendModel: HandyJSON {
    var msg: String = ""
    var ret: Int = 0
    var code: String = ""
    var list: [TTFMRecommendModel]?
}

struct TTFMRecommendModel: HandyJSON {
    var bottomHasMore: Bool = false
    var hasMore: Bool = false
    var list: [TTFMRecommendListModel]?
    var loopCount: Int = 0
    var moduleId: Int = 0
    var moduleType: String?
    var showInterestCard: Bool = false
    var title: String?
    
    var target: TTFMTarget?
    var recWords: [TTFMRecWords]?
    
    var categoryId: Int = 0
    var direction: String?
    var keywords: [TTFMKeywords]?
}

struct TTFMRecommendListModel: HandyJSON {
    var albumId: Int = 0
    var categoryId: Int = 0
    var commentsCount: Int = 0
    var commentScore: CGFloat = 0.0
    var discountedPrice: CGFloat = 0.0
    var displayDiscountedPrice: String?
    var displayPrice: String?
    var infoType: String?
    var isDraft: Bool = false
    var isFinished: Int = 0
    var isPaid: Bool = false
    var isVipFree: Bool = false
    var lastUptrackAt: Int = 0
    var materialType: String?
    var nickname: String?
    var pic: String?
    var playsCount: Int = 0
    var price: CGFloat = 0.0
    var priceTypeEnum: Int = 0
    var priceUnit: String?
    var recSrc: String?
    var recTrack: String?
    var refundSupportType: Int = 0
    var subtitle: String?
    var title: String?
    var tracksCount: Int = 0
    var vipFreeType: Int = 0
    var coverPath: String?
}

struct TTFMTarget: HandyJSON {
    var groupId: Int = 0
    var categoryId: Int = 0
}

struct TTFMRecWords: HandyJSON {
    var contentType: String = ""
    var properties: TTFMProperties?
    var title: String = ""
}

struct TTFMKeywords: HandyJSON {
    var categoryId: Int = 0
    var keywordId: Int = 0
    var keywordType: Int = 0
    var realCategoryId: Int = 0
    var categoryTitle: String?
    var keywordName: String?
    var materialType: String?
}

struct TTFMProperties: HandyJSON {
    var isPaid: Bool = false
    var type: String?
    var uri: String?
    var albumId: Int = 0
}

// MARK: - 推荐: 广告数据
struct TTFMRecommendAdModel: HandyJSON {
    var shareData: TTFMRecommendAdShareModel?
    var isShareFlag: Bool = false
    var thirdStatUrl: String?
    var thirdShowStatUrls: [Any]?
    var thirdClickStatUrls: [Any]?
    var showTokens: [Any]?
    var clickTokens: [Any]?
    var recSrc: String?
    var recTrack: String?
    var link: String?
    var realLink: String?
    var adMark: String?
    var isLandScape: Bool = false
    var isInternal: Int = 0
    var bucketIds: String?
    var adpr: String?
    var planId: Int = 0
    var cover: String?
    var showstyle: Int = 0
    var name: String?
    var description: String?
    var scheme: String?
    var linkType: Int = 0
    var displayType: Int = 0
    var clickType: Int = 0
    var openlinkType: Int = 0
    var loadingShowTime: Int = 0
    var apkUrl: String?
    var adtype: Int = 0
    var auto: Bool = false
    var position: Int = 0
    var subCover: String?
    var subName: String?
    var adid: Int = 0
}

struct TTFMRecommendAdShareModel: HandyJSON {
    var linkUrl: String?
    var linkTitle: String?
    var linkCoverPath: String?
    var linkContent: String?
    var isExternalUrl: Bool = false
}

// MARK: - 推荐: 听头条数据
struct TTFMRecommendNewsModel: HandyJSON {
    var albumId: Int = 0
    var albumTitle: String?
    var commentsCounts: Int = 0
    var coverSmall: String?
    var createdAt: Int = 0
    var duration: Int = 0
    var favoritesCounts: Int = 0
    var id: Int = 0
    var isAuthorized: Bool = false
    var isFree: Bool = false
    var isPaid: Bool = false
    var nickname: String?
    var playPath32: String?
    var playPath64: String?
    var playPathAacv164: String?
    var playPathAacv224: String?
    var playsCounts: Int = 0
    var priceTypeId: Int = 0
    var sampleDuration: Int = 0
    var sharesCounts: Int = 0
    var tags: String?
    var title: String?
    var trackId: Int = 0
    var uid: Int = 0
    var updatedAt: Int = 0
    var userSource: Int = 0
}

// MARK: - 推荐: 九宫格数据
struct TTFMRecommendSquareModel: HandyJSON {
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
    var properties: TTFMProperties?
}

// MARK: - 推荐: 轮播数据
struct TTFMRecommendFocusModel: HandyJSON {
    var data: [TTFMBannerModel]?
    var responseId: Int = 0
    var ret : Int = 0
}

struct TTFMBannerModel: HandyJSON {
    var adId: Int = 0
    var adType: Int = 0
    var buttonShowed: Bool = false
    var clickAction: Int = 0
    var clickTokens:[Any]?
    var clickType: Int = 0
    var cover: String?
    var description: String?
    var displayType: Int = 0
    var isAd: Bool = false
    var isInternal: Int = 0
    var isLandScape: Bool = false
    var isShareFlag: Bool = false
    var link: String?
    var name: String?
    var openlinkType: Int = 0
    var realLink: String?
    var showTokens: [Any]?
    var targetId: Int = 0
    var thirdClickStatUrls: [Any]?
    var thirdShowStatUrls: [Any]?
}

// MARK: - 懒人电台
struct TTFMOneKeyListenModel: HandyJSON {
    var channelId: Int = 0
    var channelName: String?
    var cover: String?
    var coverRound: String?
    var onLineNum: Int = 0
    var recInfo: TTFMRectInfo?
    
    struct TTFMRectInfo: HandyJSON {
        var recSrc: String?
        var recTrack: String?
    }
}

// MARK: - 直播
struct TTFMRecommendLiveModel: HandyJSON {
    var actualStartAt: Int = 0
    var categoryId: Int = 0
    var chatId: Int = 0
    var categoryName: String?
    var coverLarge: String?
    var coverMiddle: String?
    var coverSmall: String?
    var description: String?
    var endAt: Int = 0
    var id: Int = 0
    var name: String?
    var nickname: String?
    var playCount: Int = 0
    var recSrc: String?
    var recTrack: String?
    var roomId: Int = 0
    var startAt: Int = 0
    var status: Int = 0
    var uid: Int = 0
}
