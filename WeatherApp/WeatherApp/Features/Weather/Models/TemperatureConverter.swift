//
//  TemperatureConverter.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/4.
//

import Foundation

struct TemperatureConverter {
    /// 开尔文 转 摄氏度
    static func kelvinToCelsius(_ degrees: Double) -> Double {
        return round(degrees - 273.15)
    }
        
    /// 开尔文 转 华氏度
    static func kelvinToFahrenheit(_ degrees: Double) -> Double {
        return round(degrees * 9 / 5 - 459.67)
    }
}
