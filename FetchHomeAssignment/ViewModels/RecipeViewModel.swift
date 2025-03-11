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

    enum States {
        case loading
        case loaded([Recipe], images: [UUID: UIImage])
        case error(Error)
        case idle
    }

    var currentState: States = .idle
    let networkManager: NetworkManager

    init() {
        networkManager = NetworkManager.shared
        getRecipes()
    }

    func getRecipes() {
        currentState = .loading
        Task {
            do {
                let recipies = try await networkManager.loadRecipes(from: Endpoints.validData).recipes
                let imageDict = await getImages(for: recipies)
                currentState = .loaded(recipies, images: imageDict)
            } catch let error {
                currentState = .error(error)
            }
        }
    }

    func getImages(for recipies: [Recipe]) async -> [UUID: UIImage] {
        var imagesDict = [UUID: UIImage]()

        await withTaskGroup(of: (UUID, UIImage?).self) { group in
            for recipe in recipies {
                guard let stringUrl = recipe.photoUrlSmall else {
                    currentState = .error(CustomError.NoImageUrl)
                    continue
                }
                guard let uID = UUID(uuidString: recipe.uuid) else {
                    currentState = .error(CustomError.InvalidUUID)
                    continue
                }
                group.addTask { [weak self] in
                    do {
                        let image = try await self?.networkManager.imageCacheLoader.loadImage(from: stringUrl)
                        return (uID, image)
                    } catch {
                        return (uID, nil)
                    }
                }
            }

            for await result in group {
                if let image = result.1 {
                    imagesDict[result.0] = image
                }
            }
        }
        return imagesDict
    }

}
