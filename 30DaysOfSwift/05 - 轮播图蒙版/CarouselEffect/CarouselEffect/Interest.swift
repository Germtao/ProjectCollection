//
//  Interest.swift
//  CarouselEffect
//
//  Created by QDSG on 2020/5/8.
//  Copyright © 2020 tTao. All rights reserved.
//

import Foundation
import UIKit

struct Interest {
    var title = ""
    var description = ""
    var numberOfMembers = 1
    var numberOfPosts = 1
    var featuredImage: UIImage?
    
    static func createInterests() -> [Interest] {
        return [
            Interest(title: "Hello there, i miss u.",
                     description: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨",
                     featuredImage: UIImage(named: "hello")),
            Interest(title: "🐳🐳🐳🐳🐳",
                     description: "We love romantic stories. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨",
                     featuredImage: UIImage(named: "dudu")),
            Interest(title: "Training like this, #bodyline",
                     description: "Create beautiful apps. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨",
                     featuredImage: UIImage(named: "bodyline")),
            Interest(title: "I'm hungry, indeed.",
                     description: "Cars and aircrafts and boats and sky. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨",
                     featuredImage: UIImage(named: "wave")),
            Interest(title: "I have no idea, bitch",
                     description: "Get up to date with breaking-news. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨",
                     featuredImage: UIImage(named: "hhhhh")),
        ]
    }
}
