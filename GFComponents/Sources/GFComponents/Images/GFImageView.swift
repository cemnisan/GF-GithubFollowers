//
//  GFImageView.swift
//  
//
//  Created by Cem Nisan on 21.04.2022.
//

import UIKit.UIImageView

public final class GFImageView: UIImageView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(image: UIImage) {
        self.init(frame: .zero)
        
        self.image = image
    }
}

extension GFImageView {
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds      = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
