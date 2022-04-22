//
//  GFSecondaryLabel.swift
//  
//
//  Created by Cem Nisan on 23.04.2022.
//

import UIKit

public final class GFSecondaryLabel: UILabel {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
}

extension GFSecondaryLabel {
    
    private func configure() {
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.90
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
