//
//  FollowersBuilder.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import UIKit

final class FollowersBuilder {
    
    static func build(with viewModel: FollowersViewModelProtocol) -> UIViewController {
        let viewController = FollowersViewController(viewModel: viewModel)
        
        return viewController
    }
}
