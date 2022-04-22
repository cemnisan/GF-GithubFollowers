//
//  SearchBuilder.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import UIKit.UINavigationController

final class SearchBuilder {
    
    static func build() -> UINavigationController {
        let viewController = SearchViewController()
        viewController.viewModel = SearchViewModel()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: viewController)
    }
}
