//
//  FollowersViewModelContracts.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import GFNetwork

protocol FollowersViewModelProtocol {
    var username: String { get }
    var delegate: FollowersViewModelDelegate? { get set }
    
    func loadFollowers(pageNumber: Int) async
    func isFollowersEmpty() -> Bool
}

protocol FollowersViewModelDelegate: AnyObject {
    func handleOutput(output: FollowersViewModelOutput)
}

enum FollowersViewModelOutput {
    case loadFollowers([FollowerPresentation])
    case isLoading(Bool)
    case requestError(HTTPRequestError)
}
