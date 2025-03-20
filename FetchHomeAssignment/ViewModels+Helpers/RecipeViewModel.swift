//
//  RecipeViewModel.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 06.03.2025.
//

import Foundation
import SwiftUI

@MainActor
class RecipeViewModel: ObservableObject {

    let networkManager: NetworkManager

    @Published private(set) var currentState: States = .idle
    @Published private(set) var recipes: [RecipeDTO] = []
    @Published var presentAsList: Bool = true

    var columnCount = 3
    var groupedRecipes: [String: [RecipeDTO]] {
        Dictionary(grouping: recipes, by: \.cuisine)
    }

    var sortedCuisines: [String] {
        Array(groupedRecipes.keys).sorted()
    }

    init() {
        networkManager = NetworkManager.shared
    }

    func getRecipes() async {
        currentState = .loading

        do {
            let recipesNetworkResponse = try await networkManager
                .recipeFetchWorker
                .loadRecipes(from: Endpoints.validData)
                .recipes
            let mappedRecipes = recipesNetworkResponse
                .compactMap { try? RecipeDTO(recipe: $0) }
                .sorted { $0.cuisine < $1.cuisine }
            recipes = mappedRecipes
            currentState = .loaded

        } catch let error {
            currentState = .error(error)
        }
    }

    func getImage(for recipe: RecipeDTO) async throws -> UIImage? {
        guard let photoURL = recipe.photoUrlSmall else {
            return UIImage(named: "TestImage")
        }
        return try await networkManager.imageCacheWorker.loadImage(from: photoURL)
    }
}
