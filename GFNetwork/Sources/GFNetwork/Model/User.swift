//
//  File.swift
//  
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation

struct User: Codable {
    var login: String
    var id: Int
    var nodeID: String
    var avatarURL: String
    var gravatarID: String
    var url, htmlURL, followersURL: String
    var followingURL, gistsURL, starredURL: String
    var subscriptionsURL, organizationsURL, reposURL: String
    var eventsURL: String
    var receivedEventsURL: String
    var type: String
    var siteAdmin: Bool
    var name: String
    var company: String?
    var blog: String
    var location: String
    var email, hireable: String?
    var bio: String
    var twitterUsername: String?
    var publicRepos, publicGists, followers, following: Int
    var createdAt, updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, hireable, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
