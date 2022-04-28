//
//  FavoritesViewModelContracts.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 27.04.2022.
//

import Foundation

protocol FavoritesViewModelProtocol {
    var delegate: FavoritesViewModelDelegate? { get set }
    
    func loadFavorites()
    func removeFavorite(at index: Int)
    
    func favoriteCellViewModel(at index: Int) -> FavoritesCellViewModel
    func numberOfFavorites() -> Int
    func selectedFavorite(at index: Int)
}

protocol FavoritesViewModelDelegate: AnyObject {
    func handleOutput(output: FavoritesViewModelOutput)
    func navigate(to router: FavoritesViewModelRouter)
}

enum FavoritesViewModelRouter {
    case toFollowers(FollowersViewModelProtocol)
}

enum FavoritesViewModelOutput {
    case loadFavorites
}
