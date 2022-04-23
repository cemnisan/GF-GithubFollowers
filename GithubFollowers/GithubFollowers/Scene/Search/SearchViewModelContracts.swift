//
//  SearchViewModelContracts.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation

protocol SearchViewModelProtocol {    
    func searchButtonDidTapped(username: String)
}

protocol SearchViewModelDelegate: AnyObject {
    func navigate(to router: SearchViewModelRouter)
}

enum SearchViewModelRouter {
    case followers(FollowersViewModelProtocol)
}
