//
//  FavoritesTableViewCell.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 27.04.2022.
//

import UIKit
import GFComponents

final class FavoritesTableViewCell: UITableViewCell {

    static let reuseID = "FavoritesTableViewCell"
    
    private let userImageView = GFImageView(frame: .zero)
    private let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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

extension FavoritesTableViewCell {
    
    private func configure() {
        addSubviews(userImageView, usernameLabel)
        
        accessoryType = .disclosureIndicator
        
        configureImageView()
        configureUsernameLabel()
    }
    
    private func configureImageView() {
        NSLayoutConstraint.activate([
            userImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            userImageView.heightAnchor.constraint(equalToConstant: 60),
            userImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureUsernameLabel() {
        NSLayoutConstraint.activate([
            usernameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func set(with viewModelCell: FavoritesCellViewModel) {
        usernameLabel.text = viewModelCell.username
        userImageView.setUserImage(with: viewModelCell.image)
    }
}
