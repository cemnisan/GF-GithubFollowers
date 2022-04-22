//
//  File.swift
//  
//
//  Created by Cem Nisan on 23.04.2022.
//

import Foundation

enum UserInfoEndpoint: HTTPEndpoint {
    case user(username: String)
}

extension UserInfoEndpoint {
    
    var path: String {
        switch self {
        case .user(let username):
            return "/\(username)"
        }
    }
}
