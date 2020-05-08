//
//  ViewController.swift
//  SetLocation
//
//  Created by QDSG on 2020/5/8.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet private weak var locationLabel: UILabel!
    
    private var locationManager: CLLocationManager?
    
    @IBAction fileprivate func refreshMyLocation(_ sender: UIButton) {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationLabel.text = "刷新位置错误：\(error.localizedDescription)"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        CLGeocoder().reverseGeocodeLocation(location) { (placeMarks, error) in
            
            guard error == nil else {
                self.locationLabel.text = error?.localizedDescription
                return
            }
            
            if let marks = placeMarks, marks.count > 0, let placeMark = marks.first {
                self.displayLocationInfo(placeMark)
            } else {
                self.locationLabel.text = "从地址解析器收到的数据有问题..."
            }
        }
    }
}

extension ViewController {
    fileprivate func displayLocationInfo(_ placeMark: CLPlacemark) {
        // 停止更新位置以节省电池寿命
        locationManager?.stopUpdatingLocation()
        
        let locality = placeMark.locality ?? ""
        let postalCode = placeMark.postalCode ?? ""
        let administrativeArea = placeMark.administrativeArea ?? ""
        let country = placeMark.country ?? ""
        
        locationLabel.text = "\(postalCode) \(locality)\n\(administrativeArea),\(country)"
    }
}

