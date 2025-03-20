//
//  ImageCacheLoader.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 05.03.2025.
//

import Foundation
import UIKit

actor ImageCacheLoader: ImageFetchWorker {

    private let cache = DataStore.shared.imageCache

    init() { }

    public func loadImage(from url: URL) async throws -> UIImage {
        let key = url.absoluteString as NSString

        if let cachedImage = cache.object(forKey: key) {
            return cachedImage
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        if let image = UIImage(data: data) {
            cache.setObject(image, forKey: key)
            return image
        } else {
            throw URLError(.cannotParseResponse)
        }
    }

    public func clearCache() {
        cache.removeAllObjects()
    }
}
