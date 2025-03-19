//
//  States.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 10.03.2025.
//

import Foundation

enum States: Equatable {
    case loading
    case loaded
    case error(Error)
    case idle

    static func == (lhs: States, rhs: States) -> Bool {
        switch(lhs, rhs) {
        case (.idle, idle), (.loading, .loading), (.error, .error), (.loaded, .loaded):
            return true
        default:
            return false
        }
    }
}
