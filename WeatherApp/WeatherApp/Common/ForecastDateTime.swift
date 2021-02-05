//
//  ForecastDateTime.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/5.
//

import Foundation

struct ForecastDateTime {
    let rawDate: Double
    let timeZone: TimeZone
    
    init(rawDate: Double, timeZone: TimeZone) {
        self.rawDate = rawDate
        self.timeZone = timeZone
    }
    
    var shortTime: String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm"
        let date = Date(timeIntervalSince1970: rawDate)
        return formatter.string(from: date)
    }
}
