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
    func removeFavorites(at index: Int)
    func favoriteCellViewModel(at index: Int) -> FavoritesCellViewModel
    func numberOfRowsInSection() -> Int
}

protocol FavoritesViewModelDelegate: AnyObject {
    func handleOutput(output: FavoritesViewModelOutput)
}

enum FavoritesViewModelOutput {
    case loadUser
}
