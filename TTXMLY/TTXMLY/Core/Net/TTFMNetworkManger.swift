//
//  TTFMNetworkManger.swift
//  TTXMLY
//
//  Created by QDSG on 2021/3/4.
//  Copyright © 2021 unitTao. All rights reserved.
//

import Foundation
import SwiftyJSON
import Moya

class TTFMNetworkManager: NSObject {
    static let shared = TTFMNetworkManager()
    
    func request<T: TargetType>(target: T, finished: @escaping (JSON?, String?, RequestErrorCode) -> Void) {
        let provider = MoyaProvider<T>(requestClosure: requestTimeoutClosure(target: target))
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let mapJson = try response.mapJSON()
                    let json = JSON(mapJson)
                    finished(json, nil, .success)
                } catch let error {
                    finished(nil, error.localizedDescription, .failure)
                }
            case .failure(let error):
                finished(nil, error.errorDescription, .failure)
            }
        }
    }
    
    /// 设置一个公共请求超时
    private func requestTimeoutClosure<T: TargetType>(target: T) -> MoyaProvider<T>.RequestClosure {
       let requestTimeoutClosure = { (endPoint: Endpoint, done: @escaping MoyaProvider<T>.RequestResultClosure) in
           do {
               var request = try endPoint.urlRequest()
               request.timeoutInterval = 30
               done(.success(request))
           } catch {
               return
           }
       }
       return requestTimeoutClosure
    }
}
