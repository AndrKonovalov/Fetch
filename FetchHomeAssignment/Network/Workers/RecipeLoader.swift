//
//  Untitled.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 10.03.2025.
//

import Foundation

actor RecipeLoader: RecipeFetchWorker {

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
