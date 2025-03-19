//
//  RecipeDTO.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 16.03.2025.
//

import Foundation

struct RecipeDTO: Identifiable {
    let id: UUID
    let cuisine: String
    let name: String
    let photoUrlLarge: URL?
    let photoUrlSmall: URL?
    let sourceUrl: URL?
    let youtubeUrl: URL?

    init(recipe: Recipe) throws {
        guard let uuid = UUID(uuidString: recipe.uuid) else {
            throw CustomErrors.invalidUUID
        }

        id = uuid
        cuisine = recipe.cuisine
        name = recipe.name
        self.photoUrlLarge = URL(string: recipe.photoUrlLarge ?? "") ?? nil
        self.photoUrlSmall = URL(string: recipe.photoUrlSmall ?? "") ?? nil
        self.sourceUrl = URL(string: recipe.sourceUrl ?? "") ?? nil
        self.youtubeUrl = URL(string: recipe.youtubeUrl ?? "") ?? nil
    }

    init(id: UUID,
         cuisine: String,
         name: String) {
        self.id = id
        self.cuisine = cuisine
        self.name = name
        photoUrlLarge = nil
        photoUrlSmall = nil
        sourceUrl = nil
        youtubeUrl = nil
    }
}
