//
//  Endpoints.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 05.03.2025.
//

import Foundation

enum Endpoints {
    static let validData = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    static let mailformedData = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    static let emptyData = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    static let accessDeniedURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-invalid-url"

    static let invalidURL = "aaaaaaaa"
    static let badURL = ""
    static let imageURl = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg"
}
