//
//  FavoritesBuilder.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import UIKit.UINavigationController

final class FavoritesBuilder {
    
    static func build() -> UINavigationController {
        let viewController = FavoritesViewController()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: viewController)
    }
}
