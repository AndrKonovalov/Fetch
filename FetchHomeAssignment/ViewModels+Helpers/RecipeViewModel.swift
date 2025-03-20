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
    @Published private(set) var groupedRecipes: [String: [RecipeDTO]] = [:]
    @Published private(set) var sortedCuisines: [String] = []
    @Published var presentAsList: Bool = true

    var columnCount = 3

    init() {
        networkManager = NetworkManager.shared
    }

    func getRecipes() async {
        currentState = .loading

        do {
            let recipesNetworkResponse = try await Task.detached {
                try await NetworkManager.shared
                    .recipeFetchWorker
                    .loadRecipes(from: Endpoints.validData)
                    .recipes
            }.value
            let mappedRecipes = try recipesNetworkResponse
                .compactMap { try RecipeDTO(recipe: $0) }
                .sorted { $0.cuisine < $1.cuisine }
            recipes = mappedRecipes
            recalcGroupAndSort()
            currentState = .loaded

        } catch let error {
            currentState = .error(error)
        }
    }

    func getImage(for recipe: RecipeDTO) async throws -> UIImage? {
        guard let photoURL = recipe.photoUrlSmall else {
            return UIImage(named: "TestImage")
        }
        return try await Task.detached { try await NetworkManager.shared.imageCacheWorker.loadImage(from: photoURL) }.value
    }

    private func recalcGroupAndSort() {
        let grouped = Dictionary(grouping: recipes, by: \.cuisine)
        groupedRecipes = grouped
        sortedCuisines = grouped.keys.sorted()
    }
}
