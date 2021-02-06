//
//  OpenWeatherMapService.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/4.
//

import Foundation
import CoreLocation
import SwiftyJSON

struct OpenWeatherMapService: WeatherServiceProtocol {
    private let urlPath = "http://api.openweathermap.org/data/2.5/forecast"
    
    // MARK: - WeatherServiceProtocol
    func retrieveWeatherInfo(_ location: CLLocation, completionHandler: @escaping WeatherCompletionHandler) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        guard let url = generateRequestURL(location) else {
            let error = TTError(errorCode: .urlError)
            completionHandler(nil, error)
            return
        }
        
        print("天气数据 url: \(url)")
        
        let task = session.dataTask(with: url) { (data, response, error) in
            // 检查网络错误
            guard error == nil else {
                let error = TTError(errorCode: .networkRequestFailed)
                completionHandler(nil, error)
                return
            }
            
            // 检查 JSON 序列化错误
            guard let data = data else {
                let error = TTError(errorCode: .jsonSerializationFailed)
                completionHandler(nil, error)
                return
            }
            
            guard let json = try? JSON(data: data) else {
                let error = TTError(errorCode: .jsonParsingFailed)
                completionHandler(nil, error)
                return
            }
            
            print("天气数据 json: \(json)")
            
            // 获取温度、位置和图标，并检查解析错误
            guard let temperatureDegrees = json["list"][0]["main"]["temp"].double,
                  let country = json["city"]["country"].string,
                  let city = json["city"]["name"].string,
                  let weatherCondition = json["list"][0]["weather"][0]["id"].int,
                  let iconString = json["list"][0]["weather"][0]["icon"].string else {
                let error = TTError(errorCode: .jsonParsingFailed)
                completionHandler(nil, error)
                return
            }
            
            var weatherBuilder = WeatherBuilder()
            let temperature = Temperature(country: country, openWeatherMapDegrees: temperatureDegrees)
            
            weatherBuilder.temperature = temperature.degrees
            weatherBuilder.location = city
            
            let weatherIcon = WeatherIcon(condition: weatherCondition, iconString: iconString)
            
            weatherBuilder.iconText = weatherIcon.iconText
            weatherBuilder.forecasts = getFirstFourForecasts(json)
            
            completionHandler(weatherBuilder.build(), nil)
        }
        
        task.resume()
    }
}

extension OpenWeatherMapService {
    private func getFirstFourForecasts(_ json: JSON) -> [Forecast] {
        var forecasts: [Forecast] = []
        
        for index in 0...3 {
            guard let forecastTempDegrees = json["list"][index]["main"]["temp"].double,
                  let rawDateTime = json["list"][index]["dt"].double,
                  let forecastCondition = json["list"][index]["weather"][0]["id"].int,
                  let forecastIcon = json["list"][index]["weather"][0]["icon"].string,
                  let country = json["city"]["country"].string else { break }
            
            let forecastTemperature = Temperature(country: country, openWeatherMapDegrees: forecastTempDegrees)
            let forecastTimeString = ForecastDateTime(rawDate: rawDateTime, timeZone: TimeZone.current).shortTime
            let weatherIcon = WeatherIcon(condition: forecastCondition, iconString: forecastIcon)
            let forecastIconText = weatherIcon.iconText
            
            let forecast = Forecast(time: forecastTimeString,
                                    iconText: forecastIconText,
                                    temperature: forecastTemperature.degrees)
            forecasts.append(forecast)
        }
        return forecasts
    }
    
    /// 生成请求 URL
    private func generateRequestURL(_ location: CLLocation) -> URL? {
        guard var components = URLComponents(string: urlPath) else { return nil }
        
        // get appId from Info.plist
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let params = NSDictionary(contentsOfFile: filePath),
              let appId = params["OWMAccessToken"] as? String else { return nil }
        
        print("appid: \(appId)")
        
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
