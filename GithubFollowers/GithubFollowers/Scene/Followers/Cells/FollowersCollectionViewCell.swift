//
//  FollowersCollectionViewCell.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit
import GFComponents

final class FollowersCollectionViewCell: UICollectionViewCell {
        
    private let userImageView     = GFImageView(frame: .zero)
    private let usernameLabel     = GFTitleLabel(textAlignment: .center, fontSize: 16)
        
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
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: K.Styling.minPadding),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: K.Styling.minPadding),
            userImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -K.Styling.minPadding),
            userImageView.widthAnchor.constraint(equalToConstant: K.Styling.followersImageSize),
            userImageView.heightAnchor.constraint(equalToConstant: K.Styling.followersImageSize)
        ])
    }
    
    private func configureUsernameLabel() {
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: K.Styling.minPadding),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: K.Styling.minPadding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -K.Styling.minPadding),
            usernameLabel.heightAnchor.constraint(equalToConstant: K.Styling.midPadding)
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
