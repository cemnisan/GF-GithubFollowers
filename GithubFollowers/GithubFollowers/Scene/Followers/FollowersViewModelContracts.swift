//
//  FollowersViewModelContracts.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import GFNetwork

protocol FollowersViewModelProtocol {
    var username: String { get set }
    var pageNumber: Int { get set }
    var isFollowersEmpty: Bool { get }
    var hasMoreFollowers: Bool { get set }
    var delegate: FollowersViewModelDelegate? { get set }
    
    func loadFollowers() async
    func followersDidLoad()
    func filterFollowersIfSearching(isSearching: Bool, searchText: String?)
    func selectedFollower(index: Int, isSearching: Bool)
}

protocol FollowersViewModelDelegate: AnyObject {
    func handleOutput(output: FollowersViewModelOutput)
    func navigate(to router: FollowersViewModelRouter)
}

enum FollowersViewModelRouter {
    case userInfo(UserInfoViewModelProtocol)
}

enum FollowersViewModelOutput {
    case loadFollowers([FollowerPresentation])
    case isLoading(Bool)
    case requestError(HTTPRequestError)
    case filterableFollowers([FollowerPresentation])
}
