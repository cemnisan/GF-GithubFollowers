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
        notify(.loadUser)
    }
    
    func removeFavorites(at index: Int) {
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
}

// MARK: Output Helper
extension FavoritesViewModel {
    
    private func notify(_ output: FavoritesViewModelOutput) {
        delegate?.handleOutput(output: output)
    }
}
