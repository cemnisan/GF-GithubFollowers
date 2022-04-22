//
//  UIImageView+Ex.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit

extension UIImageView {
    
    func setUserImage(with imageURL: String) {
        Task {
            guard let image = try? await ImageLoader.shared.image(imageURL) else { return }
            
            updateImage(image)
        }
    }
    
    @MainActor func updateImage(_ image: UIImage) {
        self.image = image
    }
}
