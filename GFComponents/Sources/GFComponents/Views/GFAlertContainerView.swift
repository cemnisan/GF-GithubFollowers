//
//  GFAlertContainerView.swift
//  
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit

public final class GFAlertContainerView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GFAlertContainerView {
    
    private func configure() {
        backgroundColor     = .systemBackground
        layer.cornerRadius  = 16
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
