//
//  FollowerItemViewController.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 23.04.2022.
//

import Foundation

protocol FollowerItemInfoDelegate: AnyObject {
    func getFollowerButtonTapped(for user: UserInfoPresentation)
}

final class FollowerItemInfoViewController: ItemInfoViewController {
    
    private weak var delegate: FollowerItemInfoDelegate?
    
    init(user: UserInfoPresentation, delegate: FollowerItemInfoDelegate) {
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
        delegate?.getFollowerButtonTapped(for: user)
    }
}

extension FollowerItemInfoViewController {
    
    private func configure() {
        itemInfoViewOne.set(with: .followers, count: user.followers)
        itemInfoViewTwo.set(with: .following, count: user.following)
        itemActionButton.set(with: .systemGreen, K.Button.getFollowerButtonTitle)
    }
}
