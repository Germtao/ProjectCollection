//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/4.
//

import Foundation
import CoreLocation
import UIKit

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
    private var shareService: ShareService
    
    private var bindVc: UIViewController?
    
    // MARK: - init
    init(bindVc: UIViewController?) {
        self.bindVc = bindVc
        
        hasError = Observable(false)
        errorMessage = Observable(nil)
        
        location = Observable(emptyString)
        iconText = Observable(emptyString)
        temperature = Observable(emptyString)
        forecasts = Observable([])
        
        // 可以在这里放依赖注入
        locationService = LocationService()
        weatherService = OpenWeatherMapService()
        shareService = ShareService()
    }
    
    // MARK: - Public
    /// 开始定位服务
    func startLocationService() {
        locationService.delegate = self
        locationService.requestLocation()
    }
    
    func startShareService() {
        shareService.delegate = self
        shareService.share(bindVc)
    }
}

extension WeatherViewModel {
    private func update(_ weather: Weather) {
        hasError.value = false
        errorMessage.value = nil
        
        location.value = weather.location
        iconText.value = weather.iconText
        temperature.value = weather.temperature
        
        let tempForecasts = weather.forecasts.map { forecast in
            return ForecastViewModel(forecast)
        }
        forecasts.value = tempForecasts
    }
    
    private func update(_ error: TTError) {
        hasError.value = true
        
        switch error.errorCode {
        case .urlError:
            errorMessage.value = "气象服务无法正常工作。"
        case .networkRequestFailed:
            errorMessage.value = "网络似乎已关闭。"
        case .jsonSerializationFailed:
            errorMessage.value = "我们在处理天气数据时遇到了麻烦。"
        case .jsonParsingFailed:
            errorMessage.value = "我们在解析天气数据时遇到了麻烦。"
        case .unableToFindLocation:
            errorMessage.value = "我们在获取用户位置时遇到问题。"
        }
        
        location.value = emptyString
        iconText.value = emptyString
        temperature.value = emptyString
        forecasts.value = []
    }
}

// MARK: - LocationServiceDelegate
extension WeatherViewModel: LocationServiceDelegate {
    func locationDidUpdate(_ service: LocationService, location: CLLocation) {
        weatherService.retrieveWeatherInfo(location) { (weather, error) in
            DispatchQueue.main.async {
                if let unwrappedError = error {
                    print("location did update error: \(unwrappedError)")
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedWeather = weather else { return }
                
                self.update(unwrappedWeather)
            }
        }
    }
    
    func locationDidFail(withError error: TTError) {
        update(error)
    }
}

extension WeatherViewModel: ShareServiceDelegate {
    func shareDidSuccess(_ service: ShareService) {
        print("分享成功")
    }
    
    func shareDidFail(_ service: ShareService, error: Error?) {
        print("分享失败 error: \(error?.localizedDescription ?? "Unknown Error.")")
    }
}
