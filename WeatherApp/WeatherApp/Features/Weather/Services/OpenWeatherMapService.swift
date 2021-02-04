//
//  OpenWeatherMapService.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/4.
//

import Foundation
import CoreLocation

struct OpenWeatherMapService: WeatherServiceProtocol {
    private let urlPath = "http://api.openweathermap.org/data/2.5/forecast"
    
    
    
    // MARK: - WeatherServiceProtocol
    func retrieveWeatherInfo(_ location: CLLocation, completionHandler: @escaping WeatherCompletionHandler) {
        
    }
}

extension OpenWeatherMapService {
    private func generateRequestURL(_ location: CLLocation) -> URL? {
        guard var components = URLComponents(string: urlPath) else { return nil }
        
        // get appId from Info.plist
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let params = NSDictionary(contentsOfFile: filePath),
              let appId = params["OWMAccessToken"] as? String else { return nil }
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: latitude),
            URLQueryItem(name: "lon", value: longitude),
            URLQueryItem(name: "appid", value: appId)
        ]
        
        return components.url
    }
}
