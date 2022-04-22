//
//  UserInfoHeaderViewController.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 23.04.2022.
//

import UIKit
import GFComponents

final class UserInfoHeaderViewController: UIViewController {

    private let userImageView       = GFImageView(frame: .zero)
    private let usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: 34)
    private let nameLabel           = GFSecondaryLabel(fontSize: 18)
    private let locationImageView   = GFImageView(image: UIImage(systemName: "mappin.and.ellipse")!)
    private let locationLabel       = GFSecondaryLabel(fontSize: 18)
    private let bioLabel            = GFBodyLabel(textAlignment: .left)
    
    private var user: UserInfoPresentation!
    
    init(user: UserInfoPresentation) {
        super.init(nibName: nil, bundle: nil)
        
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIElements()
        configure()
    }
}

// MARK: - Configure
extension UserInfoHeaderViewController {
    
    private func configureUIElements() {
        userImageView.setUserImage(with: user.avatarUrl)
        usernameLabel.text  = user.login
        nameLabel.text      = user.name
        locationLabel.text  = user.location
        bioLabel.text       = user.bio

    }
    
    private func configure() {
        view.addSubviews(userImageView,
                         usernameLabel,
                         nameLabel,
                         locationImageView,
                         locationLabel,
                         bioLabel)
        configureUserImageView()
        configureUserNameLabel()
        configureNameLabel()
        configureLocationImageView()
        configureLocationLabel()
        configureBioLabel()
    }
    
    private func configureUserImageView() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            userImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 90),
            userImageView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func configureUserNameLabel() {
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: userImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    private func configureNameLabel() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureLocationImageView() {
        NSLayoutConstraint.activate([
            locationImageView.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureLocationLabel() {
        NSLayoutConstraint.activate([
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureBioLabel() {
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 12),
            bioLabel.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}
