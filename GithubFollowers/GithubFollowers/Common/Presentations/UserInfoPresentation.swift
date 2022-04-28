//
//  UserInfoPresentation.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 23.04.2022.
//

import GFNetwork

struct UserInfoPresentation: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
    
    init(user: User) {
        self.login          = user.login
        self.avatarUrl      = user.avatarURL
        self.name           = user.name
        self.location       = user.location
        self.bio            = user.bio
        self.publicRepos    = user.publicRepos
        self.publicGists    = user.publicGists
        self.htmlUrl        = user.htmlURL
        self.following      = user.following
        self.followers      = user.followers
        self.createdAt      = user.createdAt
    }
}
