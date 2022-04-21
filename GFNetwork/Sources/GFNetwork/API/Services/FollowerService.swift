//
//  File.swift
//  
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation

public final class FollowerService {
    public init() { }
}

extension FollowerService: FollowerServiceable {
    
    public func getUserFollowers(with username: String) async -> Result<[Follower]> {
        return await NetworkManager.shared.execute(model: [Follower].self,
                                                   endpoint: FollowerEndpoint.follower(username: username))
    }
}
