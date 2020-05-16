//
//  HomeViewController.swift
//  TumblrMenu
//
//  Created by QDSG on 2020/5/11.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToMainVc(_ sender: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
}
