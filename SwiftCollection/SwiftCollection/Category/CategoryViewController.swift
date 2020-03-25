//
//  CategoryViewController.swift
//  SwiftCollection
//
//  Created by QDSG on 2020/3/24.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UIButton.initializeMethod()
    }
    
}

extension CategoryViewController {
    @IBAction private func reclickAction(_ sender: UIButton) {
        print("点击")
    }
}
