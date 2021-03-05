//
//  TTFMSubCategoryApi.swift
//  TTXMLY
//
//  Created by QDSG on 2021/3/5.
//  Copyright © 2021 unitTao. All rights reserved.
//

import Foundation
import Moya

enum TTFMSubCategoryApi {
    case headerCategoryList(categoryId: Int)
    case categoryRecommendList(categoryId: Int)
    case categoryOtherContentList(categoryId: Int, keywordId: Int)
}

extension TTFMSubCategoryApi: TargetType {
    var baseURL: URL {
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
    var path: String {
        switch self {
        case .headerCategoryList:
            return "/discovery-category/keyword/all/1534468874767"
        case .categoryRecommendList:
            return "/discovery-category/v2/category/recommend/ts-1534469064622"
        case .categoryOtherContentList:
            return "/mobile/discovery/v2/category/metadata/albums/ts-1534469378814"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    private var params: [String: Any] {
        switch self {
        case .headerCategoryList(let categoryId):
            return [
                "categoryId": categoryId,
                "device": "iPhone",
                "gender": 9
            ]
        case .categoryRecommendList(let categoryId):
            return [
                "categoryId": categoryId,
                "appid": 0,
                "device": "iPhone",
                "gender": 9,
                "inreview": false,
                "network": "WIFI",
                "operator": 3,
                "scale": 3,
                "uid": 124057809,
                "version": "6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString
            ]
        case .categoryOtherContentList(let categoryId, let keywordId):
            return [
                "categoryId": categoryId,
                "keywordId": keywordId,
                "calcDimension": "hot",
                "device": "iPhone",
                "pageId": 1,
                "pageSize": 20,
                "status": 0,
                "version": "6.5.3"
            ]
        }
    }
}
