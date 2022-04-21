//
//  AppRouter.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation
import UIKit

final class AppRouter {
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
}

extension AppRouter {
    
    func start(with windowScene: UIWindowScene) {
        let tabBar                      = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        tabBar.tabBar.backgroundColor   = .systemGray5
        tabBar.viewControllers          = [SearchBuilder.build(), FavoritesBuilder.build()]
        
        window.windowScene              = windowScene
        window.rootViewController       = tabBar
        window.makeKeyAndVisible()
    }
}
