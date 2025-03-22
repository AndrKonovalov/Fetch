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
    @Environment(\.openURL) var openURL

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
                        ? Color.black.opacity(UIC.shadowOpacity)
                        : Color.white.opacity(UIC.shadowOpacity),
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
                        .multilineTextAlignment(.leading)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)

                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
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
