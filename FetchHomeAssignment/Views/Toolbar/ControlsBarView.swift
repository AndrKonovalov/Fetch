//
//  ControlsBar.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 06.03.2025.
//

import Foundation
import SwiftUI

struct ControlsBarView: View {
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject var viewModel: RecipeViewModel
    @Binding var scrollTo: String?
    @Binding var selectedSection: String
    var sections: [String]?

    let animationNameSpace: Namespace.ID

    var body: some View {
        VStack {
            HStack {
                Spacer()

                Button {
                    withAnimation {
                        viewModel.presentAsList.toggle()
                    }
                }
                label: {
                    Image(systemName: viewModel.presentAsList ? "rectangle.grid.2x2.fill" : "rectangle.grid.1x2.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                .foregroundStyle(.gray)
                .padding(.trailing  )
            }
            ScrollBarView(scrollTo: $scrollTo,
                          selectedSection: $selectedSection,
                          sections: sections,
                          animationNameSpace: animationNameSpace)
        }
        .padding(.bottom)
        .background(colorScheme == .light ? Color.white : Color.black)
    }
}

struct CBVPContainer: View {

    @Namespace private var animatedNamespace
    var viewModel = RecipeViewModel()

    @State var scrollTo: String? = "aaa"
    @State var selectedSection: String = "asdfsdf"
    @State var sections: [String] = [
        "asdfsdf",
        "sdfsdfb",
        "csdfsdf",
        "sdfasdfasdf",
        "asdfasdfa",
        "aaadffs"
    ]

    var body: some View {
        ControlsBarView(viewModel: viewModel,
                        scrollTo: $scrollTo,
                        selectedSection: $selectedSection,
                        sections: sections,
                        animationNameSpace: animatedNamespace)
    }
}

#Preview {
    CBVPContainer()
}
