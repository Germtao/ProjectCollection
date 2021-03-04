//
//  TTFMRecommendAPI.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/2.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

let TTFMRecommendProvider = MoyaProvider<TTFMRecommendAPI>()

struct TTFMRecommendAPIKey {
    static let adBase = "http://adse.ximalaya.com"
    static let base   = "http://mobile.ximalaya.com"
    static let recommendList = "/discovery-firstpage/v2/explore/ts-1532411485052"
    static let recommendListForU = "/mobile/discovery/v4/recommend/albums"
    static let recommendListWithAd = "/ting/feed/ts-1532656780625"
    static let guessULikeMoreList = "/discovery-firstpage/guessYouLike/list/ts-1534815616591"
    static let changeGuessULikeList = "/discovery-firstpage/guessYouLike/cycle/ts-1535167862593"
    static let changePaidCategoryList = "/mobile/discovery/v1/guessYouLike/paidCategory/ts-1535167980873"
    static let changeLiveList = "/lamia/v1/hotpage/exchange"
    static let changeOtherCategoryList = "/mobile/discovery/v4/albums/ts-1535168024113"
}

enum TTFMRecommendAPI {
    /// 推荐列表
    case recommendList
    /// 为你推荐
    case recommendListForU
    /// 推荐页面的广告
    case recommendListWithAd
    /// 猜你喜欢更多列表
    case guessULikeMoreList
    /// 更换猜你喜欢
    case changeGuessULikeList
    /// 更换精品
    case changePaidCategoryList
    /// 更换直播
    case changeLiveList
    /// 更换其他
    case changeOtherCategoryList(categoryId: Int)
}

extension TTFMRecommendAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .recommendListWithAd:
            return URL(string: TTFMRecommendAPIKey.adBase)!
        default:
            return URL(string: TTFMRecommendAPIKey.base)!
        }
    }
    
    var path: String {
        switch self {
        case .recommendList: return TTFMRecommendAPIKey.recommendList
        case .recommendListForU: return TTFMRecommendAPIKey.recommendListForU
        case .recommendListWithAd: return TTFMRecommendAPIKey.recommendListWithAd
        case .guessULikeMoreList: return TTFMRecommendAPIKey.guessULikeMoreList
        case .changeGuessULikeList: return TTFMRecommendAPIKey.changeGuessULikeList
        case .changePaidCategoryList: return TTFMRecommendAPIKey.changePaidCategoryList
        case .changeLiveList: return TTFMRecommendAPIKey.changeLiveList
        case .changeOtherCategoryList: return TTFMRecommendAPIKey.changeOtherCategoryList
        }
    }
    
    var method: Moya.Method { return .get }
    
    var task: Task {
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: .utf8)! }
    
    var headers: [String : String]? { return nil }
    
    private var params: [String: Any] {
        switch self {
        case .recommendList:
            return [
                "device": "iPhone",
                "appid": 0,
                "categoryId": -2,
                "channel": "ios-b1",
                "code": "43_310000_3100",
                "includeActivity": true,
                "includeSpecial": true,
                "network": "WIFI",
                "operator": 3,
                "pullToRefresh": true,
                "scale": 3,
                "uid": 0,
                "version": "6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString
            ]
        case .recommendListForU:
            return [
                "device": "iPhone",
                "excludedAlbumIds": "3144231%2C3160816%2C5088879%2C3703879%2C9723091%2C12580785%2C12610571%2C13507836%2C11501536%2C12642314%2C4137349%2C10587045%2C6233693%2C4436043%2C16302530%2C15427120%2C13211141%2C61%2C220565%2C3475911%2C3179882%2C10596891%2C261506%2C7183288%2C203355%2C3493173%2C7054736%2C10728301%2C2688602%2C13048404",
                "appid": 0,
                "categoryId": -2,
                "pageId": 1,
                "pageSize": 20,
                "network": "WIFI",
                "operator": 3,
                "scale": 3,
                "uid": 124057809,
                "version": "6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString
            ]
        case .recommendListWithAd:
            return [
                "device": "iPhone",
                "appid": 0,
                "name":"find_native",
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970)
            ]
        case .guessULikeMoreList:
            return [
                "device": "iPhone",
                 "appid": 0,
                 "inreview": false,
                 "network":"WIFI",
                 "operator": 3,
                 "pageId": 1,
                 "pageSize": 20,
                 "scale":3,
                 "uid": 124057809,
                 "version": "6.5.3",
                 "xt": Int32(Date().timeIntervalSince1970),
                 "deviceId": UIDevice.current.identifierForVendor!.uuidString
            ]
        case .changeGuessULikeList:
            return [
                "device": "iPhone",
                 "appid": 0,
                 "excludedAdAlbumIds": "8258116%2C8601255%2C16514340",
                 "excludedAlbumIds": "4169245%2C4156778%2C4078652%2C8601255%2C4177638%2C16514340%2C5993267%2C12201334%2C13089888%2C4310827%2C4792267%2C2912127%2C13403391%2C4193171%2C5411224%2C8258116%2C4323493%2C10829913",
                 "excludedRoomIds": "",
                 "excludedSpecialIds": "",
                 "excludedOffset": 18,
                 "inreview": false,
                 "loopIndex": 3,
                 "network":"WIFI",
                 "operator": 3,
                 "pageId": 1,
                 "pageSize": 6,
                 "scale":3,
                 "uid": 0,
                 "version": "6.5.3",
                 "xt": Int32(Date().timeIntervalSince1970),
                 "deviceId": UIDevice.current.identifierForVendor!.uuidString
            ]
        case .changePaidCategoryList:
            return [
                "device":"iPhone",
                "appid":0,
                "excludedAdAlbumIds":13616258,
                "excludedOffset":18,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":3,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString
            ]
        case .changeLiveList:
            return [
                "currentRecordIds":"1655918%2C1671613%2C1673030%2C1670774%2C1673082%2C1672407",
                "pageId":1,
                "pageSize":6,
                "device":"iPhone"
            ]
        case .changeOtherCategoryList(let categoryId):
            return [
                "categoryId": categoryId,
                "appid":0,
                "excludedAlbumIds":"7024810%2C8424399%2C8125936",
                "excludedAdAlbumIds":"13616258",
                "excludedOffset":3,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":3,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString
            ]
        }
    }
}
