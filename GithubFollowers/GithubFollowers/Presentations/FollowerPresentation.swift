//
//  FollowerPresentation.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import Foundation
import GFNetwork

struct FollowerPresentation: Hashable {
    
    var login: String
    var avatarURL: String
    
    init(follower: Follower) {
        self.login      = follower.login
        self.avatarURL  = follower.avatarURL
    }
}
