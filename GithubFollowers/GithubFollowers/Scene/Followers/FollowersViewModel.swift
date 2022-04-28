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
    private var followersService: FollowerServiceable
    private var userService: UserInfoServiceable
        
    init(followersService: FollowerServiceable,
         userService: UserInfoServiceable,
         username: String) {
        self.followersService  = followersService
        self.userService       = userService
        self.username          = username
    }
}

// MARK: - Loader
extension FollowersViewModel {
    
    func loadFollowers() async {
        notify(.isLoading(true))
        let result = await followersService.getUserFollowers(with: username, pageNumber: pageNumber)
        notify(.isLoading(false))
        
        followersResults(results: result)
    }
    
    func userDidTappedAddFavoritesButton() async {
        notify(.isLoading(true))
        let result = await userService.getUserInfo(with: username)
        notify(.isLoading(false))
        
        userResults(results: result)
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
    
    private func userResults(results: Result<User>) {
        switch results {
        case .success(let user):
            let userPresentation = UserInfoPresentation(user: user)
            addUserToUserDefaults(with: userPresentation)

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

// MARK: - UserDefaults Helper
extension FollowersViewModel {
    
    private func addUserToUserDefaults(with user: UserInfoPresentation) {
        let userDefaults = UserDefaultsManager()
        var favorites: [UserInfoPresentation] = userDefaults.getArrayFormLocal(key: .favorites)
    
        let isAlreadyInFavorites = favorites.contains { $0.login == user.login }
        guard !isAlreadyInFavorites else {
            notify(.isAlreadyInFavorites)
            return
        }
    
        favorites.append(user)
        userDefaults.setArrayToLocal(key: .favorites, array: favorites)
        notify(.addFavorites)
    }
}

// MARK: - Output Helper
extension FollowersViewModel {
    
    private func notify(_ output: FollowersViewModelOutput) {
        delegate?.handleOutput(output: output)
    }
}
