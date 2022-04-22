//
//  File.swift
//  
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation

public struct User: Codable {
    public let login: String
    public let id: Int
    public let nodeID: String
    public let avatarURL: String
    public var gravatarID: String
    public let url, htmlURL, followersURL: String
    public let followingURL, gistsURL, starredURL: String
    public let subscriptionsURL, organizationsURL, reposURL: String
    public let eventsURL: String
    public let receivedEventsURL: String
    public let type: String
    public let siteAdmin: Bool
    public var name: String?
    public var company: String?
    public let blog: String?
    public var location: String?
    public let hireable: Bool?
    public var email: String?
    public var bio: String?
    public var twitterUsername: String?
    public let publicRepos, publicGists, followers, following: Int
    public let createdAt, updatedAt: String

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
