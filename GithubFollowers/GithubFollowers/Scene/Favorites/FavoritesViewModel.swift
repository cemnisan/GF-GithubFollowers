//
//  FavoritesViewModel.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 27.04.2022.
//

import GFNetwork

final class FavoritesViewModel {
    
    weak var delegate: FavoritesViewModelDelegate?
    var favorites: [UserInfoPresentation] = []
    
    init() {}
}

// MARK: - Loader
extension FavoritesViewModel: FavoritesViewModelProtocol
{
    func loadFavorites() {
        let userDefaults                      = UserDefaultsManager()
        let favorites: [UserInfoPresentation] = userDefaults.getArrayFormLocal(key: .favorites)
        self.favorites                        = favorites
        notify(.loadFavorites)
    }
    
    func removeFavorite(at index: Int) {
        let userDefaults = UserDefaultsManager()
        favorites.remove(at: index)
        userDefaults.setArrayToLocal(key: .favorites, array: favorites)
    }
}

// MARK: - TableView Operations
extension FavoritesViewModel {
    
    func numberOfRowsInSection() -> Int {
        return favorites.count
    }
    
    func favoriteCellViewModel(at index: Int) -> FavoritesCellViewModel {
        let favorite  = favorites[index]
        let viewModel = FavoritesCellViewModel(favorite: favorite)
        
        return viewModel
    }
    
    func selectedFavorite(at index: Int) {
        let favorite           = favorites[index]
        let userService        = UserInfoService()
        let followersViewModel = FollowersViewModel(followersService: app.followersService,
                                                    userService: userService,
                                                    username: favorite.login)
        notify(.toFollowers(followersViewModel))
    }
}

// MARK: Output Helper
extension FavoritesViewModel {
    
    private func notify(_ output: FavoritesViewModelOutput) {
        delegate?.handleOutput(output: output)
    }
    
    private func notify(_ router: FavoritesViewModelRouter) {
        delegate?.navigate(to: router)
    }
}
