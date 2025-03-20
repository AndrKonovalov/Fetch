//
//  DataStore.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 19.03.2025.
//

import Foundation
import UIKit

class DataStore {

    static let shared = DataStore()

    let imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 100 * 1024 * 1024
        return cache
    }()

    init() {}
}
