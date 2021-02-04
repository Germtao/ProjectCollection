//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/4.
//

import Foundation
import CoreLocation

class WeatherViewModel {
    private let emptyString = ""
    
    let hasError: Observable<Bool>
    let errorMessage: Observable<String?>
    
    let location: Observable<String>
    let iconText: Observable<String>
    let temperature: Observable<String>
    let forecasts: Observable<[ForecastViewModel]>
    
    private var locationService: LocationService
    private var weatherService: WeatherServiceProtocol
    
    init() {
        hasError = Observable(false)
        errorMessage = Observable(nil)
        
        location = Observable(emptyString)
        iconText = Observable(emptyString)
        temperature = Observable(emptyString)
        forecasts = Observable([])
        
        // 可以在这里放依赖注入
        locationService = LocationService()
//        weatherService = Open
    }
}
