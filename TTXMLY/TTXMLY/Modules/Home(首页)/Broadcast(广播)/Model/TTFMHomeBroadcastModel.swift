//
//  TTFMHomeBroadcastModel.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/11.
//  Copyright © 2019 unitTao. All rights reserved.
//

import HandyJSON

struct TTFMHomeBroadcastModel: HandyJSON {
    var ret: Int = 0
    var data: TTFMBroadcastRadiosModel?
}

struct TTFMBroadcastRadiosModel: HandyJSON {
    var categories: [TTFMRadiosCategoriesModel]?
    var localRaios: [TTFMRadiosModel]?
    var radioSquareResults: [TTFMRadiosSquareResultsModel]?
    var topRadios: [TTFMRadiosModel]?
}

struct TTFMRadiosCategoriesModel: HandyJSON {
    var id: Int = 0
    var name: String?
}

struct TTFMRadiosModel: HandyJSON {
    var coverLarge: String?
    var coverSmall: String?
    var name: String?
    var programName: String?
    var playUrl: [TTFMRadiosPlayUrlModel]?
    
    var fmUid: Int = 0
    var id: Int = 0
    var playCount: Int = 0
    var programId: Int = 0
    var programScheduleId: Int = 0
}

struct TTFMRadiosPlayUrlModel: HandyJSON {
    var aac24: String?
    var aac64: String?
    var ts24: String?
    var ts64: String?
}

// MARK: -
struct TTFMRadiosSquareResultsModel: HandyJSON {
    var icon: String?
    var title: String?
    var uri: String?
    var id: Int = 0
}
