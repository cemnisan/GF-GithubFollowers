//
//  UIImageView+Ex.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit

extension UIImageView {
    
    func setUserImage(with imageURL: String) {
        self.image = K.Image.emptyImageView
        
        Task {
            guard let image = try? await ImageLoader.shared.image(imageURL) else { return }
            
            updateImage(image)
        }
    }
    
    func updateImage(_ image: UIImage) {
        DispatchQueue.main.async { self.image = image }
    }
}
