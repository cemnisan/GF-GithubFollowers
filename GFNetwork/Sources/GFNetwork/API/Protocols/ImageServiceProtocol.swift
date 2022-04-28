//
//  File.swift
//  
//
//  Created by Cem Nisan on 29.04.2022.
//

import Foundation
import UIKit

public protocol ImageServiceable {
    func downloadImage(with urlString: String) async throws -> UIImage
}
