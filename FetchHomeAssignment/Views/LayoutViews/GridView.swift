//
//  GridView.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 16.03.2025.
//

import Foundation
import SwiftUI

struct GridView: View {
    @Binding var viewModel: RecipeViewModel

    private var gridColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(minimum: 100)), count: viewModel.columnCount)
    }
    var body: some View {
        LazyVGrid(columns: gridColumns) {
            ForEach(viewModel.recipes) { (recipe: RecipeDTO) in
                GridCell(viewModel: $viewModel,
                         recipe: recipe)
            }
        }
    }
}
