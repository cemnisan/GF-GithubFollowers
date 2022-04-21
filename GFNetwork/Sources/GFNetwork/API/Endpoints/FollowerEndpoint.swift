//
//  File.swift
//  
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation

enum FollowerEndpoint: HTTPEndpoint {
    case follower(username: String)
}

extension FollowerEndpoint {
    
    var path: String {
        switch self {
        case .follower(let username):
            return "/users/\(username)/followers?per_page=100&page=\(1)"
        }
    }
}
