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
    
    var window: UIWindow?
    
    private enum Screens {
        case appSearch
        case musicSearch
    }
    private var currentScreen: Screens = .appSearch
    
    func openAppSearch() {
        guard let window = window else { return }
        
        currentScreen = .appSearch
        let rootVC = SearchBuilder.build()
        rootVC.navigationItem.title = "Search iTunes Apps"
        
        let navVC = self.configuredNavigationController
        navVC.viewControllers = [rootVC]
        
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        performAnimation()
    }
    
    func openMusicSearch() {
        guard let window = window else { return }
        
        currentScreen = .musicSearch
        let rootVC = SearchMusicBuilder.build()
        rootVC.navigationItem.title = "Search iTunes Music"
        
        let navVC = self.configuredNavigationController
        navVC.viewControllers = [rootVC]
        
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        performAnimation()
    }
    
    private func performAnimation() {
        guard let window = window else { return }
        
        let options: UIView.AnimationOptions
        
        switch currentScreen {
        case .appSearch:
            options = .transitionFlipFromLeft
        case .musicSearch:
            options = .transitionFlipFromRight
        }

        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: {_ in })
    }
    
    private lazy var configuredNavigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }()
}
