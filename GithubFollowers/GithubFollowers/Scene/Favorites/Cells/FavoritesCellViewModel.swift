//
//  FavoritesCellViewModel.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 27.04.2022.
//

import Foundation

struct FavoritesCellViewModel {
    let username: String
    let image: String
    
    init(favorite: UserInfoPresentation) {
        self.username = favorite.login
        self.image    = favorite.avatarUrl
    }
}
