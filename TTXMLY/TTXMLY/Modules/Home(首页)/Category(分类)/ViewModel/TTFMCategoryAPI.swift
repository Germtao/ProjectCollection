//
//  TTFMCategoryAPI.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/9.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Moya
import HandyJSON

let TTFMCategoryProvider = MoyaProvider<TTFMCategoryAPI>()

enum TTFMCategoryAPI {
    case categoryList
}

extension TTFMCategoryAPI: TargetType {
    var baseURL: URL { return URL(string: "http://mobile.ximalaya.com")! }
    
    var path: String { return "/mobile/discovery/v5/categories/1532410996452?channel=ios-b1&code=43_310000_3100&device=iPhone&gender=9&version=6.5.3%20HTTP/1.1" }
    
    var method: Moya.Method { return .get }
    
    var sampleData: Data { return "".data(using: .utf8)! }
    
    var task: Task { return .requestPlain }
    
    var headers: [String : String]? { return nil }
}
