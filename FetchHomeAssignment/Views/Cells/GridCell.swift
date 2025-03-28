//
//  CollectionCell.swift
//  FetchHomeAssignment
//
//  Created by Andrei Konovalov on 06.03.2025.
//

import Foundation
import SwiftUI

struct GridCell: View {

    @ObservedObject var viewModel: RecipeViewModel
    @State var image: UIImage?

    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL

    var recipe: RecipeDTO

    var width: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return CGFloat(screenWidth - 4 * UIC.padding) / CGFloat(viewModel.columnCount)
    }

    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: width)
                    .cornerRadius(UIC.cornerRadius)
                    .shadow(radius: UIC.shadow)
                LinearGradient(stops: [
                    .init(color: .clear, location: 0),
                    .init(color: colorScheme == .light
                          ? .white.opacity(UIC.opacityStep)
                          : .black.opacity(UIC.opacityStep),
                          location: 0.4),
                    .init(color: colorScheme == .light
                          ? .white
                          : .black,
                          location: 1)
                ], startPoint: .center, endPoint: .bottom)
                .frame(width: width, height: width)
                .cornerRadius(UIC.cornerRadius)

            } else {
                Color.gray
                    .frame(width: width, height: width)
                    .cornerRadius(UIC.cornerRadius)
            }

            VStack {
                Spacer()
                VStack {
                    Text(recipe.name)
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text(recipe.cuisine)
                        .multilineTextAlignment(.leading)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
                .padding(2)
            }
            .frame(width: width, height: width)
        }
        .frame(width: width, height: width)
        .shadow(color: colorScheme == .light
                ? Color.black.opacity(UIC.shadowOpacity)
                : Color.white.opacity(UIC.shadowOpacity),
                radius: UIC.shadow * 2)
        .task {
            do {
                image = try await viewModel.getImage(for: recipe)
            } catch {
                image = UIImage(systemName: "photo")
            }
        }
        .onTapGesture {
            if let youtubeURL = recipe.youtubeUrl {
                openURL(youtubeURL)
            }
        }
    }
}

struct CCPContainer: View {
    var viewModel = RecipeViewModel()
    var mockedRecipe = RecipeDTO(id: UUID(),
                                 cuisine: "Medeteranian",
                                 name: "Pizza")
    var body: some View {
        HStack {
            GridCell(viewModel: viewModel, recipe: mockedRecipe)
            GridCell(viewModel: viewModel, recipe: mockedRecipe)
            GridCell(viewModel: viewModel, recipe: mockedRecipe)
        }
    }
}

#Preview {
    CCPContainer()
}
