//
//  NewsModel.swift
//  SlideMenuTransition
//
//  Created by QDSG on 2020/5/9.
//  Copyright © 2020 tTao. All rights reserved.
//

import Foundation

struct NewsModel {
    let image: String
    let title: String
    let name: String
    let avatar: String
    
    init(image: String, avatar: String, title: String, name: String) {
        self.image = image
        self.avatar = avatar
        self.title = title
        self.name = name
    }
}

struct NewsViewModel {
    let dataSource = [
        NewsModel(image: "1", avatar: "a", title: "Love mountain.", name: "T AO"),
        NewsModel(image: "2", avatar: "b", title: "New graphic design - LIVE FREE", name: "Cole"),
        NewsModel(image: "3", avatar: "c", title: "Summer sand", name: "Daniel Hooper"),
        NewsModel(image: "4", avatar: "d", title: "Seeking for signal", name: "Noby-Wan Kenobi")
    ]
}
