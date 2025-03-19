//
//  CollectionSectionBuildable.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 18.03.2025.
//

import Foundation
import SwiftUI

struct SectionWrapper<GenericCell: View>: View {
    @Binding var viewModel: RecipeViewModel

    let cuisine: String
    let cell: (Binding<RecipeViewModel>, RecipeDTO) -> GenericCell

    var body: some View {
        let recipes = viewModel.groupedRecipes[cuisine] ?? []

        Section(header: SectionHeaderView(cuisine: cuisine)) {
            ForEach(recipes) { recipe in
                cell($viewModel, recipe)
            }
        }
    }
}
