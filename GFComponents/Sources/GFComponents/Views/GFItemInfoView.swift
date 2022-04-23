//
//  GFItemInfoView.swift
//  
//
//  Created by Cem Nisan on 23.04.2022.
//

import UIKit

public enum ItemInfoType { case repos, gists, followers, following }

public final class GFItemInfoView: UIView {

    private let symbolImageView = GFImageView(frame: .zero)
    private let titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private let countLabel      = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure
extension GFItemInfoView {
    
    private func configure() {
        [symbolImageView, titleLabel, countLabel].forEach { addSubview($0) }
        
        configureSymbolImageView()
        configureTitleLabel()
        configureCountLabel()
    }
    
    private func configureSymbolImageView() {
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func configureCountLabel() {
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}

// MARK: - Set
extension GFItemInfoView {
    
    public func set(with type: ItemInfoType, count: Int) {
        
        switch type {
        case .repos:
            symbolImageView.image = UIImage(systemName: "folder")
            titleLabel.text       = "Public repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: "text.alignleft")
            titleLabel.text       = "Public gists"
        case .followers:
            symbolImageView.image = UIImage(systemName: "heart")
            titleLabel.text       = "Followers"
        case .following:
            symbolImageView.image = UIImage(systemName: "person.2")
            titleLabel.text       = "Following"
        }
        countLabel.text           = "\(count)"
    }
}
