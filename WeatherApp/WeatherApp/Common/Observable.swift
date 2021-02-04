//
//  Observable.swift
//  WeatherApp
//
//  Created by QDSG on 2021/2/4.
//

import Foundation

/// 可观察的类
class Observable<T> {
    typealias Observer = (T) -> Void
    
    var observer: Observer?
    
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    /// 监听观察
    func observe(_ observer: Observer?) {
        self.observer = observer
        observer?(value)
    }
    
    init(_ value: T) {
        self.value = value
    }
}
