//
//  Error.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/4.
//

import Foundation

struct TTError {
    enum Code: Int {
        case urlError                = -6000
        case networkRequestFailed    = -6001
        case jsonSerializationFailed = -6002
        case jsonParsingFailed       = -6003
        case unableToFindLocation    = -6004
    }
    
    let errorCode: Code
}
