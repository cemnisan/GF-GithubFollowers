//
//  FollowersViewModelContracts.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import GFNetwork

protocol FollowersViewModelProtocol {
    var username: String { get }
    var isFollowersEmpty: Bool { get }
    var hasMoreFollowers: Bool { get set }
    var delegate: FollowersViewModelDelegate? { get set }
    
    func loadFollowers(pageNumber: Int) async
    func filterFollowersIfSearching(isSearching: Bool, searchText: String?)
    func selectedFollower(index: Int, isSearching: Bool) -> FollowerPresentation
}

protocol FollowersViewModelDelegate: AnyObject {
    func handleOutput(output: FollowersViewModelOutput)
}

enum FollowersViewModelOutput {
    case loadFollowers([FollowerPresentation])
    case isLoading(Bool)
    case requestError(HTTPRequestError)
    case filterableFollowers([FollowerPresentation])
}
