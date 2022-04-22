//
//  SearchViewModel.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation

final class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    
    init() { }
}

// MARK: - SearchViewModel Protocol
extension SearchViewModel: SearchViewModelProtocol {
    
    func getFollowersButtonDidTapped(username: String) {
        let viewModel = FollowersViewModel(service: app.service, username: username)
        
        delegate?.navigate(to: .followers(viewModel))
    }
}
