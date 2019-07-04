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
        var paras: [String: Any] = [:]
        switch self {
        case .recommendList:
            paras = ["device": "iPhone",
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
                     "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        case .recommendListForU:
            paras = ["device": "iPhone",
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
                     "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        case .recommendListWithAd:
            paras = ["device": "iPhone",
                     "appid": 0,
                     "name":"find_native",
                     "network":"WIFI",
                     "operator":3,
                     "scale":3,
                     "version":"6.5.3",
                     "xt": Int32(Date().timeIntervalSince1970)]
        default:
            break
        }
        
        return .requestParameters(parameters: paras, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: .utf8)! }
    
    var headers: [String : String]? { return nil }
    
    
}
