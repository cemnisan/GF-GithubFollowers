//
//  SearchViewModel.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation
import GFNetwork

final class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    
    init() { }
}

// MARK: - SearchViewModel Protocol
extension SearchViewModel: SearchViewModelProtocol {
    
    func searchButtonDidTapped(username: String) {
        let userService = UserInfoService()
        let viewModel   = FollowersViewModel(followersService: app.followersService,
                                           userService: userService,
                                           username: username)
        delegate?.navigate(to: .followers(viewModel))
    }
}
