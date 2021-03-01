//
//  TTListenApi.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/26.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Foundation
import Moya

enum TTListenApi {
    /// 订阅列表
    case subscribeList
    /// 频道列表
    case channelList
    /// 更多
    case moreChannelList
}

extension TTListenApi: TargetType {
    var baseURL: URL {
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
    var path: String {
        switch self {
        case .subscribeList:
            return "/subscribe/v2/subscribe/comprehensive/rank"
        case .channelList:
            return "/radio-station/v1/subscribe-channel/list"
        case .moreChannelList:
            return "/subscribe/v3/subscribe/recommend"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data { return "".data(using: .utf8)! }
    
    var task: Task {
        var paras: [String: Any] = [:]
        switch self {
        case .subscribeList:
            paras = ["pageId": 1,
                     "pageSize": 30,
                     "device": "iPhone",
                     "sign": 2,
                     "size": 30,
                     "tsuid": 124057809,
                     "xt": Int32(Date().timeIntervalSince1970)]
        case .channelList: break
        case .moreChannelList:
            paras = ["pageId": 1,
                     "pageSize": 30,
                     "device": "iPhone"]
        }
        
        return .requestParameters(parameters: paras, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? { return nil }
    
    
}
