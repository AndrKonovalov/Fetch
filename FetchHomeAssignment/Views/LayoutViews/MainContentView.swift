//
//  ContentView.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 16.03.2025.
//

import Foundation
import SwiftUI

struct MainContentView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @Binding var scrollTo: String?
    @Binding var selectedSection: String

    @State var headerMinY: CGFloat = 0

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical) {
                if viewModel.presentAsList {
                    ListView(viewModel: viewModel,
                             selectedSection: $selectedSection,
                             headerMinY: headerMinY)
                } else {
                    GridView(viewModel: viewModel)
                }
            }
            .padding(.top)
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(SectionHeaderPreferenceKey.self) { preferences in
                let sorted = preferences.sorted { $0.minY < $1.minY }
                let offset = 50.0

                if let currHeader = preferences.first(where: { $0.id == selectedSection }),
                   currHeader.minY < offset {
                    return
                }

                if let newSection = sorted.first(where: { $0.minY >= 0 }) {
                    withAnimation {
                        selectedSection = newSection.id
                    }
                }
            }
            .onChange(of: scrollTo) { _, newValue in
                guard let newValue else { return }
                scrollTo = nil

                withAnimation {
                    proxy.scrollTo(newValue, anchor: .top)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation {
                        selectedSection = newValue
                    }
                }

            }
            .refreshable {
                
                await viewModel.getRecipes()
            }
        }
    }
}
