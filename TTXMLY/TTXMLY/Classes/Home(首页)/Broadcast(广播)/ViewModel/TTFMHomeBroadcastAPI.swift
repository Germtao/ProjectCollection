//
//  TTFMHomeBroadcastAPI.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/11.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Moya

let TTFMHomeBroadcastProvider = MoyaProvider<TTFMHomeBroadcastAPI>()

struct TTFMHomeBroadcastApiKey {
    static let host = "http://live.ximalaya.com"
    static let broadcastList = "/live-web/v5/homepage"
    static let moreList = "/live-web/v2/radio/category"
}

enum TTFMHomeBroadcastAPI {
    case broadcastList
    case broadcastCategoryList(path: String)
    case broadcastCategoryMoreList(categoryId: Int)
}

extension TTFMHomeBroadcastAPI: TargetType {
    var baseURL: URL { return URL(string: TTFMHomeBroadcastApiKey.host)! }
    
    var path: String {
        switch self {
        case .broadcastList:
            return TTFMHomeBroadcastApiKey.broadcastList
        case .broadcastCategoryList(let path):
            return path
        case .broadcastCategoryMoreList:
            return TTFMHomeBroadcastApiKey.moreList
        }
    }
    
    var method: Moya.Method { return .get }
    
    var sampleData: Data { return "{}".data(using: .utf8)! }
    
    var task: Task {
        switch self {
        case .broadcastList:
            return .requestPlain
        case .broadcastCategoryList:
            let paras: [String: Any] = ["device": "iPhone",
                                        "pageNum": 1,
                                        "pageSize": 30,
                                        "provinceCode": "310000"]
            return .requestParameters(parameters: paras, encoding: URLEncoding.default)
        case .broadcastCategoryMoreList(let categoryId):
            let paras: [String: Any] = ["device": "iPhone",
                                        "pageNum": 1,
                                        "pageSize": 30,
                                        "categoryId": categoryId]
            return .requestParameters(parameters: paras, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? { return nil }
    
    
}
