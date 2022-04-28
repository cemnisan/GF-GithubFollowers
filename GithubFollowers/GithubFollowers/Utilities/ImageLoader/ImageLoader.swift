//
//  ImageLoaders.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit
import GFNetwork

final actor ImageLoader {
    
    private enum downloadstates {
        case inProgress(Task<UIImage, Error>)
        case completed(UIImage)
        case failure
    }
    
    static let shared = ImageLoader()
    
    private var cache: [String: downloadstates] = [:]
    private var imageService: ImageServiceable
    
    private init(imageService: ImageServiceable = ImageService()) {
        self.imageService = imageService
    }
}

extension ImageLoader {
    
    private func add(_ image: UIImage, forKey key: String) {
        cache[key] = .completed(image)
    }
    
    func image(_ imageURL: String) async throws -> UIImage {
        
        if let cached = cache[imageURL] {
            switch cached {
            case .completed(let image):
                return image
            case .inProgress(let task):
                return try await task.value
            case .failure: break
            }
        }
        
        let download: Task<UIImage, Error> = Task.detached {
            return try await self.imageService.downloadImage(with: imageURL)
        }
        cache[imageURL] = .inProgress(download)
        
        do {
            let result = try await download.value
            add(result, forKey: imageURL)
            return result
        } catch {
            cache[imageURL] = .failure
            throw error
        }
    }
}
