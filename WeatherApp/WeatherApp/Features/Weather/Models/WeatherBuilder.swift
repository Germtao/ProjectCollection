//
//  WeatherBuilder.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/4.
//

import Foundation

struct WeatherBuilder {
    var location: String?
    var iconText: String?
    var temperature: String?
    
    var forecasts: [Forecast]?
    
    func build() -> Weather {
        return Weather(
            location: location ?? "",
            iconText: iconText ?? "",
            temperature: temperature ?? "",
            forecasts: forecasts ?? []
        )
    }
}
