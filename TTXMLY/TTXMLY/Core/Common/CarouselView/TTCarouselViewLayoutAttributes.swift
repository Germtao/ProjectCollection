//
//  TTCarouselViewLayoutAttributes.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/3.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

open class TTCarouselViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    open var position: CGFloat = 0.0
    
    open override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? TTCarouselViewLayoutAttributes else { return false }
        
        var isEqual = super.isEqual(object)
        isEqual = isEqual && (position == object.position)
        return isEqual
    }
    
    open override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! TTCarouselViewLayoutAttributes
        copy.position = position
        return copy
    }
}
