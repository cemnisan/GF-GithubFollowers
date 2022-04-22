//
//  File.swift
//  
//
//  Created by Cem Nisan on 23.04.2022.
//

import Foundation

public protocol UserInfoServiceable {
    func getUserInfo(with username: String) async -> Result<User>
}
