//
//  UserInfoViewModelContracts.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import Foundation

protocol UserInfoViewModelProtocol {
    var userJoinedDate: Date! { get set }
    var delegate: UserInfoViewModelDelegate? { get set }
    
    func loadUserInfo() async
}

protocol UserInfoViewModelDelegate: AnyObject {
    func handleOutput(output: UserInfoViewModelOutput)
}

enum UserInfoViewModelOutput {
    case loadUserInfo(UserInfoPresentation)
}
