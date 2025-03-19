//
//  NetworkManager.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 05.03.2025.
//

import Foundation

final class NetworkManager {
    public static var shared = NetworkManager()

    public var imageCacheWorker: ImageFetchWorker
    public var recipeFetchWorker: RecipeFetchWorker

    private init(imageCacheWorker: @autoclosure @escaping () -> ImageFetchWorker = { ImageCacheLoader() }(),
                 recipeFetchWorker: @autoclosure @escaping () -> RecipeFetchWorker = { RecipeLoader() }()) {
        self.imageCacheWorker = imageCacheWorker()
        self.recipeFetchWorker = recipeFetchWorker()
    }
}
