//
//  AppContainer.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation
import GFNetwork

let app = AppContainer()

final class AppContainer {
    let router                                = AppRouter()
    let followersService: FollowerServiceable = FollowerService()
    let userService: UserInfoServiceable      = UserInfoService()
}
