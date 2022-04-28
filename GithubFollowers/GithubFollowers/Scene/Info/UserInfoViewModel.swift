//
//  UserInfoViewModel.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import GFNetwork
import Foundation

final class UserInfoViewModel: UserInfoViewModelProtocol {
    
    private var username: String
    private var user: User!
    var userJoinedDate: Date!
    
    weak var delegate: UserInfoViewModelDelegate?
    private var service: UserInfoServiceable
    
    init(username: String,
         service: UserInfoServiceable) {
        self.username = username
        self.service  = service
    }
}

// MARK: - Loader
extension UserInfoViewModel {
    
    func loadUserInfo() async {
        let results = await service.getUserInfo(with: username)
        
        await userInfoResults(results: results)
    }
}

// MARK: - Results
extension UserInfoViewModel {
    
    @MainActor private func userInfoResults(results: Result<User>) {
        switch results {
        case .success(let user):
            self.user            = user
            self.userJoinedDate  = user.createdAt
            let userPresentation = UserInfoPresentation(user: self.user)
            notify(.loadUserInfo(userPresentation))
        case .failure(let error):
            print(error)
        }
    }
}

// MARK: - Notify
extension UserInfoViewModel {
    
    private func notify(_ output: UserInfoViewModelOutput) {
        delegate?.handleOutput(output: output)
    }
}
