//
//  UserDefaultsManager.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 27.04.2022.
//

import Foundation

enum UserDefaultsKeys: String { case favorites }

final class UserDefaultsManager {
    
    func create<T: Codable>(key: UserDefaultsKeys, array: [T]) {
        do {
            let userDefaults = UserDefaults.standard
            let encoder      = JSONEncoder()
            let encode       = try encoder.encode(array)
            userDefaults.set(encode, forKey: key.rawValue)
        } catch {
            print(error)
        }
    }
    
    func read<T: Codable>(key: UserDefaultsKeys) -> [T] {
        do {
            let userDefaults = UserDefaults.standard
            guard let data = userDefaults.data(forKey: key.rawValue) else { return [] }
            let decoder      = JSONDecoder()
            let decode       = try decoder.decode([T].self, from: data)
            
            return decode
        } catch {
            return []
        }
    }
}
