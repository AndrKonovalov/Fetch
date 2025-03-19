//
//  ListView.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 16.03.2025.
//

import Foundation
import SwiftUI

struct ListView: View {
    @Binding var viewModel: RecipeViewModel
    @Binding var scrollTo: String?
    @Binding var selectedSection: String

    @State var headerMinY: CGFloat

    var body: some View {
        LazyVStack {
            ForEach(viewModel.sortedCuisines, id: \.self) { cuisine in
                section(for: cuisine)
            }
        }
        .frame(maxWidth: .infinity)
        .scrollIndicators(.hidden)
    }

    @ViewBuilder
    private func section(for cuisine: String) -> some View {
        let recipes = viewModel.groupedRecipes[cuisine] ?? []
        Section(header: SectionHeaderView(cuisine: cuisine)) {
            ForEach(recipes) { recipe in
                ListCell(viewModel: $viewModel,
                         recipe: recipe)
            }
        }
    }
}
