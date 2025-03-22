//
//  SectionHeaderData.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 18.03.2025.
//

import Foundation
import SwiftUICore

struct SectionHeaderData: Equatable {
    let id: String
    let minY: CGFloat
}

struct SectionHeaderPreferenceKey: PreferenceKey {
    static var defaultValue: [SectionHeaderData] = []

    static func reduce(value: inout [SectionHeaderData], nextValue: () -> [SectionHeaderData]) {
        value.append(contentsOf: nextValue())
    }
}
