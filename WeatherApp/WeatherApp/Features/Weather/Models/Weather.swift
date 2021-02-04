//
//  Weather.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/4.
//

import Foundation

struct Weather {
    let location: String
    let iconText: String
    let temperature: String
    
    /// 预测天气
    let forecasts: [Forecast]
}
