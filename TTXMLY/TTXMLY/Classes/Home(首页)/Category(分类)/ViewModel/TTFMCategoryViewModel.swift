//
//  TTFMCategoryViewModel.swift
//  TTXMLY
//
//  Created by QDSG on 2019/7/8.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class TTFMCategoryViewModel: NSObject {
    var categoryModels: [TTFMCategoryModel]?
    
    /// 更新数据回调
    var updateDataHandler: (() -> Void)?
}

extension TTFMCategoryViewModel {
    /// 刷新数据
    func refreshData() {
        
    }
}
