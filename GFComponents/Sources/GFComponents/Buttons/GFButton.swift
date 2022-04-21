//
//  File.swift
//  
//
//  Created by Cem Nisan on 21.04.2022.
//

import UIKit

public final class GFButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(backgrounColor: UIColor,
                     title: String) {
        self.init(frame: .zero)
        
        self.backgroundColor = backgrounColor
        self.setTitle(title, for: .normal)
    }
}

extension GFButton {
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font   = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
