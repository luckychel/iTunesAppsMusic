//
//  AppStartConfigurator.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 14.04.2023.
//  Copyright © 2023 ekireev. All rights reserved.
//

import UIKit

final class ScreenManager {
    
    static let shared = ScreenManager()
    private init() {}
    
    private enum Screens {
        case appSearch
        case musicSearch
    }
    private var currentScreen: Screens = .appSearch
    
    private lazy var configuredNavigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.modalTransitionStyle = .flipHorizontal
        
        return navVC
    }()
    
    func appStart(window: UIWindow) {
        currentScreen = .appSearch
        let rootVC = SearchBuilder.build()
        rootVC.navigationItem.title = "Search iTunes Apps"
        
        let navVC = self.configuredNavigationController
        navVC.viewControllers = [rootVC]
        
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
    
    func openAppSearch() {
        currentScreen = .appSearch
        let rootVC = SearchBuilder.build()
        rootVC.navigationItem.title = "Search iTunes Apps"
        
        UIView.transition(
            with: configuredNavigationController.view,
            duration: 0.4,
            options: .transitionFlipFromLeft,
            animations: {
                self.configuredNavigationController.setViewControllers([rootVC], animated: true)
            }, completion: nil)
    }
    
    func openMusicSearch() {
        
        currentScreen = .musicSearch
        let rootVC = SearchMusicBuilder.build()
        rootVC.navigationItem.title = "Search iTunes Music"
        
        UIView.transition(
            with: configuredNavigationController.view,
            duration: 0.4,
            options: .transitionFlipFromRight,
            animations: {
                self.configuredNavigationController.setViewControllers([rootVC], animated: true)
            }, completion: nil)
    }
}
