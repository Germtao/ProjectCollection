//
//  TTFMHomeLiveAPI.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/10.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Moya

let TTFMHomeLiveApiProvider = MoyaProvider<TTFMHomeLiveAPI>()

struct TTFMHomeLiveApiKey {
    static let liveCategoryList = "/lamia/v1/homepage/materials HTTP/1.1"
    static let liveRankList = "/lamia/v2/live/rank_list"
    static let liveList = "/lamia/v8/live/homepage"
    static let categoryLiveList = "/lamia/v4/live/subchannel/homepage"
    static let categoryTypeList = "/lamia/v9/live/homepage"
    static let other = "/focusPicture/ts-1532427241140"
    
    static let baseBanner = "http://adse.ximalaya.com"
    static let baseCategory = "http://mobwsa.ximalaya.com"
    static let base = "http://mobile.ximalaya.com"
}

enum TTFMHomeLiveAPI {
    case liveCategoryList
    case liveBannerList
    case liveRankList
    case liveList
    case categoryLiveList(channelId: Int)
    case categoryTypeList(categoryType: Int)
}

extension TTFMHomeLiveAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .liveBannerList:
            return URL(string: TTFMHomeLiveApiKey.baseBanner)!
        case .categoryLiveList:
            return URL(string: TTFMHomeLiveApiKey.baseCategory)!
        default:
            return URL(string: TTFMHomeLiveApiKey.base)!
        }
    }
    
    var path: String {
        switch self {
        case .liveCategoryList:
            return TTFMHomeLiveApiKey.liveCategoryList
        case .liveRankList:
            return TTFMHomeLiveApiKey.liveRankList
        case .liveList:
            return TTFMHomeLiveApiKey.liveList
        case .categoryLiveList:
            return TTFMHomeLiveApiKey.categoryLiveList
        case .categoryTypeList:
            return TTFMHomeLiveApiKey.categoryTypeList
        default:
            return TTFMHomeLiveApiKey.other
        }
    }
    
    var method: Moya.Method { return .get }
    
    var sampleData: Data { return "".data(using: .utf8)! }
    
    var task: Task {
        switch self {
        case .categoryLiveList(let channelId):
            let paras: [String: Any] = ["appid": 0,
                                        "pageSize": 40,
                                        "network": "WIFI",
                                        "operator": 3,
                                        "scale": 3,
                                        "pageId": 1,
                                        "device": "iPhone",
                                        "version": "6.5.3",
                                        "xt": Int32(Date().timeIntervalSince1970),
                                        "channelId": channelId]
            return .requestParameters(parameters: paras, encoding: URLEncoding.default)
        case .categoryTypeList(let categoryType):
            let paras: [String: Any] = ["pageId": 1,
                                        "pageSize": 20,
                                        "sign": 1,
                                        "timeToPreventCaching": Int32(Date().timeIntervalSince1970),
                                        "categoryType": categoryType]
            return .requestParameters(parameters: paras, encoding: URLEncoding.default)
        default:
            let paras: [String: Any] = ["appid": 0,
                                        "categoryId": -3,
                                        "network": "WIFI",
                                        "operator": 3,
                                        "scale": 3,
                                        "uid": 0,
                                        "device": "iPhone",
                                        "version": "6.5.3",
                                        "xt": Int32(Date().timeIntervalSince1970),
                                        "deviceId": UIDevice.current.identifierForVendor?.uuidString ?? ""]
            return .requestParameters(parameters: paras, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? { return nil }
    
    
}
