//
//  RepoItemInfoViewController.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 23.04.2022.
//

import UIKit

protocol RepoItemInfoDelegate: AnyObject {
    func githubProfileButtonTapped(for user: UserInfoPresentation)
}

final class RepoItemInfoViewController: ItemInfoViewController {
    
    weak var delegate: RepoItemInfoDelegate?
    
    init(user: UserInfoPresentation, delegate: RepoItemInfoDelegate) {
        super.init(user: user)
        
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func itemActionButtonTapped() {
        delegate?.githubProfileButtonTapped(for: user)
    }
}

extension RepoItemInfoViewController {
    
    private func configure() {
        itemInfoViewOne.set(with: .repos, count: user.publicRepos)
        itemInfoViewTwo.set(with: .gists, count: user.publicGists)
        itemActionButton.set(with: .systemPurple, "Github Profile")
    }
}
