//
//  CustomErrors.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 10.03.2025.
//

import Foundation

enum CustomErrors: LocalizedError {

    case noImageUrl
    case invalidUUID
    case invalidDataFormat

    var errorDescription: String {
        switch self {
        case .noImageUrl:
            return "No image url"
        case .invalidUUID:
            return "Invalid UUID"
        case .invalidDataFormat:
            return "Invalid data format, Unable to initialize RecipeDTO"
        }
    }
}
