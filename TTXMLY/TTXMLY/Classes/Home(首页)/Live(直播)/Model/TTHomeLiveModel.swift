//
//  TTHomeLiveModel.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import HandyJSON

struct TTFMHomeLiveRankModel: HandyJSON {
    var ret: Int = 0
    var data: TTFMHomeLiveRankListModel?
}

struct TTFMHomeLiveRankListModel: HandyJSON {
    var hpRankRollMillisecond: Int = 0
    var multidimensionalRankVos: [TTFMMultidimensionalRankVosModel]?
}

/// 多维排行
struct TTFMMultidimensionalRankVosModel: HandyJSON {
    var dimensionType: Int = 0
    var dimensionName: String?
    var htmlUrl: String?
    var ranks: [TTFMRankList]?
}

struct TTFMRankList: HandyJSON {
    var uid: Int = 0
    var coverSmall: String?
    var nickname: String?
}

// MARK: - 直播轮播
struct TTFMHomeLiveBannerModel: HandyJSON {
    var ret: Int = 0
    var responseId: Int = 0
    var adIds: [Any]?
    var adTypes: [Any]?
    var source: Int = 0
    var data: [TTFMHomeLiveBannerList]?
}

struct TTFMHomeLiveBannerList: HandyJSON {
    var shareData: String?
    var isShareFlag: String?
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
    var isAd: Bool = false
    var targetId: Int = 0
    var clickAction: Int = 0
    var template: String?
    var buttonText: String?
    var buttonShowed: Bool = false
    var categoryTitle: String?
    var color: String?
    var adid: Int = 0
}

// MARK: - 直播分类
struct TTFMHomeLiveCategoryModel: HandyJSON {
    var ret: Int = 0
    var data: TTFMHomeLiveCategory?
}

struct TTFMHomeLiveCategory: HandyJSON {
    var showed: Bool = false
    var materialVoList: [TTFMMaterialVoList]?
}

struct TTFMMaterialVoList: HandyJSON {
    var id: Int = 0
    var type: Int = 0
    var coverPath: String?
    var targetUrl: String?
    var title: String?
}

// MARK: - 直播主播
struct TTFMHomeLiveModel: HandyJSON {
    var ret: Int = 0
    var data: TTFMHomeLiveDataModel?
}

struct TTFMHomeLiveDataModel: HandyJSON {
    var lastPage: Bool = false
    var pageId: Int = 0
    var pageSize: Int = 0
    var categoryVoList: [TTFMCategoryVoList]?
    var lives: [TTFMLivesModel]?
}

struct TTFMCategoryVoList: HandyJSON {
    var id: String?
    var name: String?
}

struct TTFMLivesModel: HandyJSON {
    var actualStartAt: Int = 0
    var avatar: String?
    var categoryId: Int = 0
    var categoryName: String?
    var chatId: Int = 0
    var coverLarge: String?
    var coverMiddle: String?
    var coverSmall: String?
    var id: Int = 0
    var mode: TTFMLiveMode?
    var name: String?
    var nickname: String?
    var permissionType: Int = 0
    var playCount: Int = 0
    
    var price: Int = 0
    var roomId: Int = 0
    var status: Int = 0
    var uid: Int = 0
    var type: Int = 0
}

struct TTFMLiveMode: HandyJSON {
    var firstColor: String?
    var modeName: String?
    var modeType: Int = 0
    var secondColor: String?
}
