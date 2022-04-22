//
//  File.swift
//  
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation

enum FollowerEndpoint: HTTPEndpoint {
    case follower(username: String, pageNumber: Int)
}

extension FollowerEndpoint {
    
    var path: String {
        switch self {
        case .follower(let username, let pageNumber):
            return "/users/\(username)/followers?per_page=100&page=\(pageNumber)"
        }
    }
}
