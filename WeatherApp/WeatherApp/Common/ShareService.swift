//
//  ShareService.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/6.
//

import Foundation
import UIKit

protocol ShareServiceDelegate {
    func shareDidSuccess(_ service: ShareService)
    func shareDidFail(_ service: ShareService, error: Error?)
}

class ShareService: NSObject {
    var delegate: ShareServiceDelegate?
    
    func share(_ target: UIViewController?) {
        let image = UIImage(named: "background")!
        let activityItems = [image]
        let activityVc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        target?.present(activityVc, animated: true, completion: nil)
        
        activityVc.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
            if completed {
                self.delegate?.shareDidSuccess(self)
            } else {
                self.delegate?.shareDidFail(self, error: error)
            }
        }
    }
}
