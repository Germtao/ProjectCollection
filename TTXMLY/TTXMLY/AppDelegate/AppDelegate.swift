//
//  AppDelegate.swift
//  TTXMLY
//
//  Created by QDSG on 2019/6/26.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import SwiftMessages

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabBar = setupTabBarStyle(delegate: self as? UITabBarControllerDelegate)
        self.window?.backgroundColor = .white
        self.window?.rootViewController = tabBar
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// MARK: - 设置 Tab Bar

extension AppDelegate {
    /// 设置tabBar style
    private func setupTabBarStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.shadowImage = #imageLiteral(resourceName: "transparent")
        tabBarController.shouldHijackHandler = { (tabBarController, viewController, index) in
            if index == 2 {
                return true
            }
            return false
        }
        tabBarController.didHijackHandler = { (tabBarController, viewController, index) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                let warning = MessageView.viewFromNib(layout: .cardView)
                warning.configureTheme(.warning)
                warning.configureDropShadow()
                
                let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
                warning.configureContent(title: "警告⚠️", body: "暂时没有此功能", iconText: iconText)
                warning.button?.isHidden = true
                var warningConfig = SwiftMessages.defaultConfig
                warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
                SwiftMessages.show(config: warningConfig, view: warning)
            })
        }
        
        let homeNav = TTNavigationController(rootViewController: TTHomeViewController())
        let listenNav = TTNavigationController(rootViewController: TTListenViewController())
        let playNav = TTNavigationController(rootViewController: TTPlayViewController())
        let findNav = TTNavigationController(rootViewController: TTFindViewController())
        let mineNav = TTNavigationController(rootViewController: TTMineViewController())
        
        homeNav.tabBarItem = ESTabBarItem(TTFMIrregularityBasicContentView(), title: "首页", image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home_s"))
        listenNav.tabBarItem = ESTabBarItem(TTFMIrregularityBasicContentView(), title: "我听", image: #imageLiteral(resourceName: "listen"), selectedImage: #imageLiteral(resourceName: "listen_s"))
        playNav.tabBarItem = ESTabBarItem(TTFMIrregularityContentView(), title: nil, image: #imageLiteral(resourceName: "tab_play"), selectedImage: #imageLiteral(resourceName: "tab_play"))
        findNav.tabBarItem = ESTabBarItem(TTFMIrregularityBasicContentView(), title: "发现", image: #imageLiteral(resourceName: "find"), selectedImage: #imageLiteral(resourceName: "find_s"))
        mineNav.tabBarItem = ESTabBarItem(TTFMIrregularityBasicContentView(), title: "我的", image: #imageLiteral(resourceName: "mine"), selectedImage: #imageLiteral(resourceName: "mine_s"))
        
        tabBarController.viewControllers = [homeNav, listenNav, playNav, findNav, mineNav]
        
        return tabBarController
    }
}

