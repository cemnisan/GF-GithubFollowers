//
//  File.swift
//  
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation

public struct FollowerResults: Codable {
    let followers: [Follower]
}

public struct Follower: Codable {
    public var login: String
    public var id: Int
    public var nodeID: String
    public var avatarURL: String
    public var gravatarID: String?
    public var url, htmlURL, followersURL: String
    public var followingURL, gistsURL, starredURL: String
    public var subscriptionsURL, organizationsURL, reposURL: String
    public var eventsURL: String
    public var receivedEventsURL: String
    public var type: String
    public var siteAdmin: Bool
    
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
    }
}
