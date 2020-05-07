//
//  YSGCameraManager.swift
//  SwiftCollection
//
//  Created by QDSG on 2020/4/16.
//  Copyright © 2020 tTao. All rights reserved.
//

import Foundation
import UIKit

struct YSGCameraManager {
    static let bundle = Bundle(for: YSGCameraViewController.classForCoder())
    
    static let itemSpacing: CGFloat = 1
    static let columns: CGFloat = 4
    static let thumbnailDimension = (UIScreen.main.bounds.width - ((columns * itemSpacing) - itemSpacing))/columns
    static let scale = UIScreen.main.scale
    
    static let photoLibraryThumbnailSize = CGSize(width: thumbnailDimension, height: thumbnailDimension)
    
    static func image(with named: String) -> UIImage? {
        return UIImage(named: named, in: bundle, compatibleWith: nil)
    }
}
