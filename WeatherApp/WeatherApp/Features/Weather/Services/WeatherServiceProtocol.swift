//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/4.
//

import Foundation
import CoreLocation

typealias WeatherCompletionHandler = (Weather?, TTError?) -> Void

protocol WeatherCompletionProtocol {
    /// 找回天气信息
    func retrieveWeatherInfo(_ location: CLLocation, completionHandler: @escaping WeatherCompletionHandler)
}
