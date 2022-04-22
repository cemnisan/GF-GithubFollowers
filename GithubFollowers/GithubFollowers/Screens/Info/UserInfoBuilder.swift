//
//  UserInfoBuilder.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit

final class UserInfoBuilder {
    
    static func build(with viewModel: UserInfoViewModelProtocol) -> UINavigationController {
        let viewController = UserInfoViewController(viewModel: viewModel)
        
        return UINavigationController(rootViewController: viewController)
    }
}
