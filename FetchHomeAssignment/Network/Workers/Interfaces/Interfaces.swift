//
//  Interfaces.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 10.03.2025.
//

import Foundation
import UIKit

protocol RecipeFetchWorker {
    func loadRecipes(from urlString: String) async throws -> RecipeResponse
}

protocol ImageFetchWorker {
    func loadImage(from url: URL) async throws -> UIImage
}
