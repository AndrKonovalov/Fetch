//
//  MainView.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 06.03.2025.
//

import SwiftUI

struct MainView: View {

    @Namespace private var animatedNamespace

    @StateObject var viewModel = RecipeViewModel()

    @State var showAlert = false
    @State var scrollTo: String?
    @State var selectedSection: String = ""
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            switch viewModel.currentState {
            case .idle, .loading:
                LoadingView()
                    .transition(.opacity)
            case .loaded:
                MainContentView(viewModel: viewModel,
                                scrollTo: $scrollTo,
                                selectedSection: $selectedSection)
                .transition(.opacity)

                VStack {
                    ControlsBarView(viewModel: viewModel,
                                    scrollTo: $scrollTo,
                                    selectedSection: $selectedSection,
                                    sections: viewModel.sortedCuisines,
                                    animationNameSpace: animatedNamespace)
                    Spacer()
                }

            case .error:
                EmptyView()
                    .transition(.slide)
                    .onChange( of: viewModel.currentState) { _, newState in
                        if case .error(let error) = newState {
                            alertMessage = error.localizedDescription
                            showAlert = true
                        }
                    }
            }
        }
        .task {
            await viewModel.getRecipes()
            scrollTo = viewModel.sortedCuisines.first
        }
        .animation(.easeInOut(duration: 1.2), value: viewModel.currentState)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    HStack {
        MainView()
    }

}
