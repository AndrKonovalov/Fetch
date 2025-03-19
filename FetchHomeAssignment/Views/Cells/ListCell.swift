//
//  ListCell.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 06.03.2025.
//

import Foundation
import SwiftUI

struct ListCell: View {

    @Binding var viewModel: RecipeViewModel
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
                    Text(recipe.cuisine)
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                        //                        Link("Watch on YouTube",
                        //                             destination: recipe.youtubeUrl) // create model for the app
                        //                            .foregroundColor(.accentColor)
                        //                            .underline()
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)

            .onAppear {
                viewModel.getImage(for: recipe)
            }
            .onDisappear {
                viewModel.cancelImageTask(for: recipe)
            }
            .task {
                if let loadedImage = await viewModel.imageTasks[recipe.id]?.value {
                    image = loadedImage
                }
            }
        }
    }
}

struct LCPContainer: View {
    @State var viewModel = RecipeViewModel()
    var mockedRecipe = RecipeDTO(id: UUID(),
                                 cuisine: "Medeteranian",
                                 name: "Pizza")
    var body: some View {
        VStack {
            ForEach(0..<50) { _ in 
                ListCell(viewModel: $viewModel,
                         recipe: mockedRecipe)
            }
        }
    }
}

#Preview {
    LCPContainer()
}
