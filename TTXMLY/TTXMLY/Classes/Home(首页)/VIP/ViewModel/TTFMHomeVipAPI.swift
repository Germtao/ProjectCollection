//
//  TTFMHomeVipAPI.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/9.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Moya

let TTFMHomeVipProvider = MoyaProvider<TTFMHomeVipAPI>()

enum TTFMHomeVipAPI {
    case vipList
}

extension TTFMHomeVipAPI: TargetType {
    var baseURL: URL { return URL(string: "http://mobile.ximalaya.com")! }
    
    var path: String { return "/product/v4/category/recommends/ts-1532592638951" }
    
    var method: Moya.Method { return .get }
    
    var sampleData: Data { return "".data(using: .utf8)! }
    
    var task: Task {
        let paras: [String: Any] = ["appid": 0,
                                    "categoryId": 33,
                                    "contentType": "album",
                                    "inreview": false,
                                    "network": "WIFI",
                                    "operator": 3,
                                    "scale": 3,
                                    "uid": 0,
                                    "device": "iPhone", "version": "6.5.3",
                                    "xt": Int32(Date().timeIntervalSince1970),
                                    "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        return .requestParameters(parameters: paras, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? { return nil }
    
    
}
