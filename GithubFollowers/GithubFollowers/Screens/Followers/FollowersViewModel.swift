//
//  FollowersViewModel.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import GFNetwork

final class FollowersViewModel: FollowersViewModelProtocol {
    
    var username: String
    @MainActor private var followers: [Follower] = []
    
    weak var delegate: FollowersViewModelDelegate?
    private var service: FollowerServiceable
    
    init(service: FollowerServiceable,
         username: String) {
        self.service  = service
        self.username = username
    }
}

// MARK: - Loader
extension FollowersViewModel {
    
    func loadFollowers(pageNumber: Int) async {
        let result = await service.getUserFollowers(with: username)
        
        await followersResults(results: result)
    }
}

// MARK: - Results
extension FollowersViewModel {
    
    @MainActor private func followersResults(results: Result<[Follower]>) {
        switch results {
        case .success(let followers):
            self.followers.append(contentsOf: followers)
            notify(.loadFollowers)
        case .failure(let error):
            notify(.requestError(error))
        }
    }
}

// MARK: - Output Helper
extension FollowersViewModel {
    
    private func notify(_ output: FollowersViewModelOutput) {
        delegate?.handleOutput(output: output)
    }
}