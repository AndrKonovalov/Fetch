//
//  Recipe.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 05.03.2025.
//

import Foundation

struct Recipe: Codable {
    let cuisine: String
    let name: String
    let photoURLLarge: String
    let photoURLSmall: String
    let uuid: String
    let sourceURL: String
    let youtubeURL: String
}
