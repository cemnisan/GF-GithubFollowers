//
//  FollowersCollectionViewCell.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit
import GFComponents

final class FollowersCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "followersCell"
    
    private let userImageView     = GFImageView(frame: .zero)
    private let usernameLabel     = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        userImageView.image = nil
        usernameLabel.text  = nil
    }
}

// MARK: - Configure
extension FollowersCollectionViewCell {
    
    private func configure() {
        addSubviews(userImageView, usernameLabel)
        
        configureImageView()
        configureUsernameLabel()
    }
    
    private func configureImageView() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            userImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            userImageView.widthAnchor.constraint(equalToConstant: 123),
            userImageView.heightAnchor.constraint(equalToConstant: 123)
        ])
    }
    
    private func configureUsernameLabel() {
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: padding),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

// MARK: - Update
extension FollowersCollectionViewCell {
    
    func update(with followers: FollowerPresentation) {
        userImageView.setUserImage(with: followers.avatarURL)
        usernameLabel.text  = followers.login
    }
}
