//
//  TTListenModel.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/26.
//  Copyright © 2019 unitTao. All rights reserved.
//

import HandyJSON

/// 专辑model
struct TTAlbumResultsModel: HandyJSON {
    var albumCover: String?
    var albumId: Int = 0
    var albumTitle: String?
    var avatar: String?
    var dynamicType: Int = 0
    var isAuthorized: Bool = false
    var isDraft: Bool = false
    var isPaid: Bool = false
    var isTop: Bool = false
    var lastUpdateAt: Int = 0
    var nickname: String?
    var serialState: Int = 0
    var status: Int = 0
    var timeline: Int = 0
    var trackId: Int = 0
    var trackTitle: String?
    var trackType: Int = 0
    var uid: Int = 0
    var unreadNum: Int = 0
}

/// 一键听 model
struct TTChannelResultsModel: HandyJSON {
    var bigCover: String?
    var channelId: Int = 0
    var channelName: String?
    var channelProperty: String?
    var cover: String?
    var createdAt: Int = 0
    var isRec: Bool = false
    var jumpUrl: String?
    var playParam: TTPlayParamModel?
    var playUrl: String?
    var slogan: String?
}


struct TTPlayParamModel: HandyJSON {
    var tabid: String?
    var pageSize: String?
    var albumId: String?
    var pageId: String?
    var isWrap: String?
}

/// 推荐model
struct TTAlbumsModel: HandyJSON {
    var albumId: Int = 0
    var coverMiddle: String?
    var coverSmall: String?
    var isDraft: Bool = false
    var isFinished: Int = 0
    var isPaid: Bool = false
    var lastUpdateAt: Int = 0
    var playsCounts: Int = 0
    var recReason: String?
    var recSrc: String?
    var recTrack: String?
    var refundSupportType: Int = 0
    var title: String?
    var tracks: Int = 0
}

/// 一键听点击添加更多频道 Model
struct TTMoreChannelListModel: HandyJSON {
    var ret: Int = 0
    var msg: String?
    var slogan: String?
    var lastVisitChannel: TTChannelInfosModel?
    var classInfos: [TTChannelClassInfoModel]?
    var recSrc: String?
    var recTrack: String?
}

struct TTChannelInfosModel: HandyJSON {
    var channelProperty: String?
    var channelId: Int = 0
    var channelName: String?
    var positionId: Int = 0
    var cover: String?
    var bigCover: String?
    var isRec: Bool = false
    var jumpUrl: String?
    var playUrl: String?
    var slogan: String?
    var playParam: TTPlayParamModel?
    var createdAt: Int = 0
    var subscribe: Bool = false
}

struct TTChannelClassInfoModel: HandyJSON {
    var className: String?
    var classId: Int = 0
    var channelInfos:[TTChannelInfosModel]?
}
