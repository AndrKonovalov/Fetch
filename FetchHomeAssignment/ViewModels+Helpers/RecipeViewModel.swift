//
//  RecipeViewModel.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 06.03.2025.
//

import Foundation
import SwiftUI

@Observable
final class RecipeViewModel {

    var currentState: States = .idle
    var recipes: [RecipeDTO] = []
    var imageTasks: [UUID: Task<UIImage?, Never>] = [:]
    var columnCount = 3
    var presentAsList: Bool = true
    let networkManager: NetworkManager

    var groupedRecipes: [String: [RecipeDTO]] {
        Dictionary(grouping: recipes, by: \.cuisine)
    }

    var sortedCuisines: [String] {
        groupedRecipes.keys.sorted()
    }

    init() {
        networkManager = NetworkManager.shared
        getRecipes()
    }

    func getRecipes() {
        currentState = .loading
        Task {
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
    }

    func getImage(for recipe: RecipeDTO) {
        imageTasks[recipe.id]?.cancel()
        imageTasks[recipe.id] = Task {
            do {
                guard let photoURL = recipe.photoUrlSmall else {
                    return UIImage(contentsOfFile: "TestImage")
                }
                let image = try await networkManager.imageCacheWorker.loadImage(from: photoURL)
                return image
            } catch let error {
                currentState = .error(error)
                return nil
            }
        }
    }

    func cancelImageTask(for recipe: RecipeDTO) {
        imageTasks[recipe.id]?.cancel()
        imageTasks[recipe.id] = nil
    }

    func getCusinesList() -> [String] {
        Set(recipes.compactMap(\.cuisine)).sorted()
    }
}
