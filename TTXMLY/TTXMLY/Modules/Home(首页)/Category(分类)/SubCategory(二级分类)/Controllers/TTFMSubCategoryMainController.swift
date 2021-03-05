//
//  TTFMSubCategoryMainController.swift
//  TTXMLY
//
//  Created by QDSG on 2021/3/5.
//  Copyright © 2021 unitTao. All rights reserved.
//

import UIKit
import DNSPageView

class TTFMSubCategoryMainController: UIViewController {
    private var categoryId: Int = 0
    private var isVipPush: Bool = false
    private var viewModel = TTFMSubCategoryViewModel()
    
    convenience init(categoryId: Int = 0, isVipPush: Bool = false) {
        self.init()
        self.categoryId = categoryId
        self.isVipPush = isVipPush
        self.viewModel = TTFMSubCategoryViewModel(categoryId: categoryId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}

extension TTFMSubCategoryMainController {
    private func makeUI() {
        view.backgroundColor = Constants.Colors.defaultBackground
        
        let style = PageStyle()
        style.isTitleViewScrollEnabled = true
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleColor = .gray
        style.titleSelectedColor = .black
        style.bottomLineColor = .black
        style.bottomLineHeight = 2
        style.titleViewBackgroundColor = Constants.Colors.viewBackground
    }
    
    private func loadData() {
        viewModel.requestHeaderCategoryKeywords()
    }
}
