//
//  NetworkManager.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 05.03.2025.
//

import Foundation

final class NetworkManager {
    public static var shared = NetworkManager()

    public var imageCacheLoader = ImageCacheLoader()

    private init() {}

    public func loadRecipes(from urlString: String) async throws -> RecipeResponse {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(RecipeResponse.self, from: data)
    }
}
