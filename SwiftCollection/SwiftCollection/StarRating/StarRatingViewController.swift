//
//  StarRatingViewController.swift
//  SwiftCollection
//
//  Created by QDSG on 2020/3/24.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class StarRatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet private weak var starRatingView: StarRatingView! {
        didSet {
            starRatingView.delegate = self
            starRatingView.currentStarCount = 3.5
//            starRatingView.clickEnable = true
            starRatingView.slideEnable = true
        }
    }
}

extension StarRatingViewController: StarRatingViewDelegate {
    func starRatingView(_ starRatingView: StarRatingView, count: Float) {
        print(count)
    }
}
