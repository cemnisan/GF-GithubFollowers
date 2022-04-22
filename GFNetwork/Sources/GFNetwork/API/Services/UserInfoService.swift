//
//  File.swift
//  
//
//  Created by Cem Nisan on 23.04.2022.
//

import Foundation

public final class UserInfoService: UserInfoServiceable {
    
    public init() { }
}

extension UserInfoService {
    
    public func getUserInfo(with username: String) async -> Result<User> {
        return await NetworkManager.shared.execute(model: User.self, endpoint: UserInfoEndpoint.user(username: username))
    }
}
