//
//  GFEmptyStateView.swift
//  
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit.UIView

public final class GFEmptyStateView: UIView {
    
    private let messageLabel  = GFTitleLabel(textAlignment: .center, fontSize: 24)
    private let logoImageView = GFImageView(image: #imageLiteral(resourceName: "empty-state-logo"))
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(message: String) {
        self.init(frame: .zero)
        
        messageLabel.text = message
    }
}

extension GFEmptyStateView {
    
    private func configure() {
        [messageLabel, logoImageView].forEach { addSubview($0) }
        
        configureMessageLabel()
        configureImageView()
    }
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines = 5
        messageLabel.textColor     = .secondaryLabel
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureImageView() {
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}
