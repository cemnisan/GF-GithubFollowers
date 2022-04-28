//
//  File.swift
//  
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation

public protocol FollowerServiceable {
    func getUserFollowers(with username: String, pageNumber: Int) async -> Result<[Follower]>
}
