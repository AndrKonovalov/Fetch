//
//  ListCell.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 06.03.2025.
//

import Foundation
import SwiftUI

struct ListCell: View {

    @ObservedObject var viewModel: RecipeViewModel
    @State var image: UIImage?
    @Environment(\.colorScheme) var colorScheme

    var recipe: RecipeDTO

    var body: some View {
        ZStack {
            Rectangle()
                .fill(colorScheme == .light
                      ? Color.white
                      : Color.black)
                .frame(width: UIScreen.main.bounds.width - UIC.padding * 4,
                       height: UIC.listImageWidth)
                .cornerRadius(UIC.cornerRadius)
                .shadow(color: colorScheme == .light
                        ? Color.black.opacity(0.3)
                        : Color.white.opacity(0.3),
                        radius: UIC.shadow * 2)
            HStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIC.listImageWidth,
                               height: UIC.listImageWidth)
                        .cornerRadius(UIC.cornerRadius)
                        .shadow(radius: UIC.shadow)
                } else {
                    Color.gray
                        .frame(width: UIC.listImageWidth,
                               height: UIC.listImageWidth)
                        .cornerRadius(UIC.cornerRadius)
                }

                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .multilineTextAlignment(.leading)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    if let youtubeURL = recipe.youtubeUrl {
                        Link("Watch on YouTube", destination: youtubeURL)
                            .foregroundColor(.secondary)
                            .underline()
                    }

                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .task {
                image = try? await viewModel.getImage(for: recipe)
            }
        }
    }
}

struct LCPContainer: View {
    var viewModel = RecipeViewModel()
    var mockedRecipe = RecipeDTO(id: UUID(),
                                 cuisine: "Medeteranian",
                                 name: "Pizza")
    var body: some View {
        VStack {
            ForEach(0..<50) { _ in
                ListCell(viewModel: viewModel,
                         recipe: mockedRecipe)
            }
        }
    }
}

#Preview {
    LCPContainer()
}
