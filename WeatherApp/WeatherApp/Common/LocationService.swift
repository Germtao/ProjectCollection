//
//  LocationService.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/4.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate {
    func locationDidUpdate(_ service: LocationService, location: CLLocation)
    func locationDidFail(withError error: TTError)
}

/// 定位服务类
class LocationService: NSObject {
    var delegate: LocationServiceDelegate?
    
    fileprivate let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("当前位置: \(location)")
            delegate?.locationDidUpdate(self, location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("发现位置错误: \(error.localizedDescription)")
        let ttError = TTError(errorCode: .unableToFindLocation)
        delegate?.locationDidFail(withError: ttError)
    }
}
