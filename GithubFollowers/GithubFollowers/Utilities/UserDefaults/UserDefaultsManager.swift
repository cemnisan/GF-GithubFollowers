//
//  UserDefaultsManager.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 27.04.2022.
//

import Foundation

enum UserDefaultsKeys: String { case favorites }

final class UserDefaultsManager {
    
    func setArrayToLocal<T: Codable>(key: UserDefaultsKeys, array: [T]) {
        guard let encode = try? JSONEncoder().encode(array) else { return }
        let userDefaults = UserDefaults.standard
        userDefaults.set(encode, forKey: key.rawValue)
    }
    
    func getArrayFormLocal<T: Codable>(key: UserDefaultsKeys) -> [T] {
        let userDefaults = UserDefaults.standard
        guard let encode = userDefaults.data(forKey: key.rawValue),
              let decode = try? JSONDecoder().decode([T].self, from: encode) else { return [] }
        return decode
    }
    
    func removeFavorites(key: UserDefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
