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
                SectionWrapper(viewModel: $viewModel, cuisine: cuisine) {
                    ListCell(viewModel: $0, recipe: $1)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .scrollIndicators(.hidden)
    }
}
