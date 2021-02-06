//
//  ForecastView.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/4.
//

import UIKit

/// @IBDesignable 和 @IBInspectable - 可重用的UI组件
@IBDesignable class ForecastView: UIView {
    /// 我们在 XIB 文件中的自定义视图
    var view: UIView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var viewModel: ForecastViewModel? {
        didSet {
            viewModel?.time.observe { [unowned self] in
                self.timeLabel.text = $0
            }
            
            viewModel?.iconText.observe { [unowned self] in
                self.iconLabel.text = $0
            }
            
            viewModel?.temperature.observe { [unowned self] in
                self.temperatureLabel.text = $0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view = loadViewFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        view = loadViewFromNib()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName(), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
        return view
    }
    
    func loadViewModel(_ viewModel: ForecastViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - IBInspectable
    @IBInspectable var time: String? {
        get { timeLabel.text }
        set { timeLabel.text = newValue }
    }
    
    @IBInspectable var icon: String? {
        get { iconLabel.text }
        set { iconLabel.text = newValue }
    }
    
    @IBInspectable var temperature: String? {
        get { temperatureLabel.text }
        set { temperatureLabel.text = newValue }
    }
    
    @IBInspectable var timeColor: UIColor {
        get { timeLabel.textColor }
        set { timeLabel.textColor = newValue }
    }
    
    @IBInspectable var iconColor: UIColor {
        get { iconLabel.textColor }
        set { iconLabel.textColor = newValue }
    }
    
    @IBInspectable var temperatureColor: UIColor {
        get { temperatureLabel.textColor }
        set { temperatureLabel.textColor = newValue }
    }
    
    @IBInspectable var bgColor: UIColor {
        get { view.backgroundColor! }
        set { view.backgroundColor = newValue }
    }
    
    // MARK: - Private
    fileprivate func nibName() -> String {
        return String(describing: type(of: self))
    }
}
