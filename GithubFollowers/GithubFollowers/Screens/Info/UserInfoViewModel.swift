//
//  UserInfoViewModel.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import GFNetwork

final class UserInfoViewModel: UserInfoViewModelProtocol {
    
    private var username: String
    @MainActor private var user: User!
    
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
            self.user = user
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
