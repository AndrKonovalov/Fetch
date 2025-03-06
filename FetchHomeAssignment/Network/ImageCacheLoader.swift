//
//  ImageCacheLoader.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 05.03.2025.
//

import Foundation
import UIKit

final class ImageCacheLoader {

    private let cache = NSCache<NSString, UIImage>()

    init() { }

    public func loadImage(from urlString: String) async throws -> UIImage? {
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            return cachedImage
        }
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        if let image = UIImage(data: data) {
            cache.setObject(image, forKey: urlString as NSString)
            return image
        } else {
            throw URLError(.cannotParseResponse)
        }
    }

    public func clearCache() {
        cache.removeAllObjects()
    }
}
