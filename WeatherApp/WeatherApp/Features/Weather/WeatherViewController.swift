//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/4.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet var forecastViews: [ForecastView]!
    
    let identifier = "WeatherIdentifier"
    
    var viewModel: WeatherViewModel? {
        didSet {
            setLocationLabel()
            viewModel?.iconText.observe { [unowned self] in
                self.iconLabel.text = $0
            }
            
            viewModel?.temperature.observe { [unowned self] in
                self.temperatureLabel.text = $0
            }
            
            setForecastView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = WeatherViewModel()
        viewModel?.startLocationService()
        
        setAccessibilityIdentifiers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureLabels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureLabelsWithAnimation()
    }
}

extension WeatherViewController {
    /// 设置服务功能标志
    private func setAccessibilityIdentifiers() {
        locationLabel.accessibilityIdentifier = "a11y_current_city"
        iconLabel.accessibilityIdentifier = "a11y_weather_icon"
        temperatureLabel.accessibilityIdentifier = "a11y_weather_temperature"
    }
    
    private func configureLabels() {
        locationLabel.center.x -= view.bounds.width
        iconLabel.center.x -= view.bounds.width
        temperatureLabel.center.x -= view.bounds.width
        iconLabel.alpha = 0.0
        locationLabel.alpha = 0.0
        temperatureLabel.alpha = 0.0
    }
    
    private func configureLabelsWithAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.locationLabel.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: []) {
            self.iconLabel.center.x += self.view.bounds.width
        } completion: { _ in }
        
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: []) {
            self.temperatureLabel.center.x += self.view.bounds.width
        } completion: { _ in }
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: []) {
            self.locationLabel.alpha = 1.0
        } completion: { _ in }
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: []) {
            self.iconLabel.alpha = 1.0
        } completion: { _ in }
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: []) {
            self.temperatureLabel.alpha = 1.0
        } completion: { _ in }
    }
    
    private func setLocationLabel() {
        viewModel?.location.observe { [unowned self] in
            self.locationLabel.text = $0
            
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            attributeSet.title = self.locationLabel.text
            
            let item = CSSearchableItem(uniqueIdentifier: self.identifier, domainIdentifier: "com.rushjet.WeatherApp", attributeSet: attributeSet)
            CSSearchableIndex.default().indexSearchableItems([item]) { error in
                if let error = error {
                    print("Indexing error: \(error.localizedDescription)")
                } else {
                    print("Location item successfully indexed.")
                }
            }
        }
    }
    
    private func setForecastView() {
        viewModel?.forecasts.observe { [unowned self] in
            if $0.count >= 4 {
                for (index, forecastView) in self.forecastViews.enumerated() {
                    forecastView.loadViewModel($0[index])
                }
            }
        }
    }
}
