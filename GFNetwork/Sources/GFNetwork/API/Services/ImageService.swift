//
//  File.swift
//  
//
//  Created by Cem Nisan on 29.04.2022.
//

import Foundation
import UIKit

public final class ImageService {
    
    public init() { }
}

extension ImageService: ImageServiceable {
    
    public func downloadImage(with urlString: String) async throws -> UIImage {
        return try await NetworkManager.shared.execute(with: urlString)
    }
}
