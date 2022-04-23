//
//  FollowersViewModel.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import GFNetwork

final class FollowersViewModel: FollowersViewModelProtocol {
    
    var username: String
    var pageNumber = 1
    var isFollowersEmpty: Bool { followers.count == 0 ? true : false }
    var hasMoreFollowers = false
    
    private var followers: [Follower]         = []
    private var filteredFollowers: [Follower] = []
    
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
    
    func loadFollowers() async {
        notify(.isLoading(true))
        let result = await service.getUserFollowers(with: username, pageNumber: pageNumber)
        notify(.isLoading(false))
        
        followersResults(results: result)
    }
}

// MARK: - Results
extension FollowersViewModel {
    
    private func followersResults(results: Result<[Follower]>) {
        switch results {
        case .success(let followers):
            if followers.count == 0 { hasMoreFollowers = true }
            self.followers.append(contentsOf: followers)
            let followersPresentation = self.followers.map { FollowerPresentation(follower: $0) }
            notify(.loadFollowers(followersPresentation))
        case .failure(let error):
            notify(.requestError(error))
        }
    }
}

// MARK: - CollectionView Operations
extension FollowersViewModel {
    
    func selectedFollower(index: Int,
                          isSearching: Bool) {
        let activeArray          = isSearching ? filteredFollowers : followers
        let follower             = activeArray[index]
        let viewModel            = UserInfoViewModel(username: follower.login, service: UserInfoService())
        
        delegate?.navigate(to: .userInfo(viewModel))
    }
}

// MARK: - Follower Helper
extension FollowersViewModel {
    
    func filterFollowersIfSearching(isSearching: Bool,
                                 searchText: String?) {
        switch isSearching {
        case true:
            filteredFollowers = followers.filter { $0.login.lowercased().contains(searchText!.lowercased()) }
            notify(.filterableFollowers(filteredFollowers.map { FollowerPresentation(follower: $0) }))
        case false:
            filteredFollowers.removeAll()
            notify(.filterableFollowers(followers.map { FollowerPresentation(follower: $0) }))
        }
    }
    
    func followersDidLoad() {
        pageNumber       = 1
        hasMoreFollowers = false
        followers.removeAll()
        filteredFollowers.removeAll()
    }
}

// MARK: - Output Helper
extension FollowersViewModel {
    
    private func notify(_ output: FollowersViewModelOutput) {
        delegate?.handleOutput(output: output)
    }
}
