//
//  MenuViewController.swift
//  TumblrMenu
//
//  Created by TT on 2020/5/16.
//  Copyright © 2020 tTao. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {
    
    let manager = TransitionManger()
    
    @IBOutlet weak var textBtn: TopImageButton!
    @IBOutlet weak var photoBtn: TopImageButton!
    @IBOutlet weak var quoteBtn: TopImageButton!
    @IBOutlet weak var linkBtn: TopImageButton!
    @IBOutlet weak var chatBtn: TopImageButton!
    @IBOutlet weak var audioBtn: TopImageButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        transitioningDelegate = manager
    }
    
}
