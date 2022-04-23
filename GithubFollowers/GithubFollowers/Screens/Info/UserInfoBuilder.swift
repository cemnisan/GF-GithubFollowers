//
//  UserInfoBuilder.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit

final class UserInfoBuilder {
    
    static func build(with viewModel: UserInfoViewModelProtocol,
                      delegate: UserInfoViewControllerDelegate) -> UIViewController {
        let viewController = UserInfoViewController(viewModel: viewModel, delegate: delegate)
        
        return viewController
    }
}
